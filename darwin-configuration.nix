{ config, pkgs, ... }:

{
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = [pkgs.zsh];
    shells = [pkgs.zsh];
  };

  programs = {
    bash.enable = true;
    zsh.enable = true;
  };

  networking.hostName = "jdw-mbp";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;

  imports = [ <home-manager/nix-darwin> ];

  home-manager.useUserPackages = true;

  home-manager.users.jdw = { pkgs, ... }: {
    nixpkgs.overlays = [ (import ./overlays) ];

    home.file = {
      ".spacemacs" = {
        source = pkgs.substituteAll {
          elixirls = pkgs.elixir-ls;
          src = ~/dev/config/spacemacs;
        };
      };
    };

    home.packages = with pkgs; [
      awscli
      bash-completion
      cargo
      direnv
      elixir
      elixir-ls
      elmPackages.elm
      emacsMacport
      iterm2
      gitAndTools.pre-commit
      gnupg
      nodejs
      pgcli
      python3
      rustc
      silver-searcher
      terraform
      vim
    ];

    programs = {
      git = {
        enable = true;
        userName = "Josiah Witt";
        userEmail = "josiah@witt.life";
      };

      tmux = {
        enable = true;
        baseIndex = 1;
        clock24 = true;
        customPaneNavigationAndResize = true;
        historyLimit = 10000;
        keyMode = "vi";
        plugins = with pkgs.tmuxPlugins; [
          resurrect
          yank
        ];
        secureSocket = false;
        shortcut = "a";
        terminal = "screen-256color";
        extraConfig = ''
          set -g default-command ${pkgs.zsh}/bin/zsh

          # Use vim keybindings in copy mode
          setw -g mode-keys vi
          unbind-key -T copy-mode-vi v
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi 'C-v' send-keys -X rectangle-toggle

          # split panes using v and s
          bind-key v split-window -h
          bind-key s split-window -v
          unbind '"'
          unbind %

          # Scrolling works as expected
          set -g terminal-overrides 'xterm*:smcup@:rmcup@'
          set -g terminal-overrides 'rxvt-unicode*:sitm@,ritm@'
        '';
      };

      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        oh-my-zsh.enable = true;

        plugins = [
          {
            name = "pi-theme";
            file = "pi.zsh-theme";
            src = pkgs.fetchFromGitHub {
              owner = "tobyjamesthomas";
              repo = "pi";
              rev = "96778f903b79212ac87f706cfc345dd07ea8dc85";
              sha256 = "0zjj1pihql5cydj1fiyjlm3163s9zdc63rzypkzmidv88c2kjr1z";
            };
          }
        ];

        shellAliases = {
          ll = "ls -la";
        };
      };
    };
  };

  services = {
    skhd = {
      enable = true;
      skhdConfig = import ./skhd.nix;
    };
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      package = pkgs.yabai;
      config = {
        focus_follows_mouse          = "autoraise";
        mouse_follows_focus          = "off";
        window_placement             = "second_child";
        window_opacity               = "off";
        window_opacity_duration      = "0.0";
        window_border                = "on";
        window_border_placement      = "inset";
        window_border_width          = 2;
        window_border_radius         = 3;
        active_window_border_topmost = "off";
        window_topmost               = "on";
        window_shadow                = "float";
        active_window_border_color   = "0xff5c7e81";
        normal_window_border_color   = "0xff505050";
        insert_window_border_color   = "0xffd75f5f";
        active_window_opacity        = "1.0";
        normal_window_opacity        = "1.0";
        split_ratio                  = "0.50";
        auto_balance                 = "on";
        mouse_modifier               = "fn";
        mouse_action1                = "move";
        mouse_action2                = "resize";
        layout                       = "bsp";
        top_padding                  = 36;
        bottom_padding               = 10;
        left_padding                 = 10;
        right_padding                = 10;
        window_gap                   = 10;
      };
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
    };

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };

    NSGlobalDomain = {
     _HIHideMenuBar = true;
     "com.apple.swipescrolldirection" = false;
    };

    screencapture.location = "/tmp";

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
