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
      ".skhdrc" = {
        source = ~/dev/config/skhdrc;
        onChange = ''
          launchctl stop org.nixos.skhd
          launchctl start org.nixos.skhd
        '';
      };

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
      skhd
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
