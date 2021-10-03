#!/bin/bash

read -p "Have you disabled SIP and installed XCode? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Disable SIP and install XCode before continuing!"
    exit 1
fi

expected_dir=~/dev/config
if [ $(pwd) != $expected_dir ]
then
    echo "Move config to ~/dev/config before running!"
    exit 1
fi

chsh -s /bin/zsh

wget -O $ZSH_CUSTOM/themes/pi.zsh-theme https://raw.githubusercontent.com/tobyjamesthomas/pi/master/pi.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Link config files
ln -s ~/dev/config/gitconfig ~/.gitconfig
ln -s ~/dev/config/skhdrc ~/.skhdrc
ln -s ~/dev/config/spacebarrc ~/.spacebarrc
ln -s ~/dev/config/spacemacs ~/.spacemacs
ln -s ~/dev/config/tmux.conf ~/.tmux.conf
ln -s ~/dev/config/yabairc ~/.yabairc

mv ~/.zshrc ~/.zshrc.bk
ln -s ~/dev/config/zshrc ~/.zshrc

# Install XCode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts

# Window Management
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai
brew install cmacrae/formulae/spacebar

sudo yabai --install-sa
sudo yabai --load-sa

brew services start skhd
brew services start yabai
brew services start spacebar

killall Dock

# General
brew install --cask bitwarden
brew install --cask cryptomator
brew install --cask dropbox
brew install --cask firefox
brew install --cask font-fontawesome
brew install --cask google-chrome
brew install --cask keepingyouawake
brew install --cask libreoffice
brew install --cask maccy
brew install --cask shifty
brew install --cask sonos
brew install --cask tidal

# Home
read -p "Install home-specific software? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install --cask backblaze
  brew install --cask garmin-express
  brew install --cask patchwork
  brew install --cask steam
  installed_garmin=true
fi

# Development
brew install --cask dash
brew install --cask docker
brew install --cask font-source-code-pro
brew install --cask insomnia
brew install --cask iterm2
brew install --cask visual-studio-code

brew install coreutils curl direnv git pre-commit terraform tmux vim wget wxmac
brew install asdf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

asdf plugin-add erlang
asdf install erlang 22.3.4.20
asdf install erlang 24.1.1
asdf global erlang 24.1.1

asdf plugin-add elixir
asdf install elixir 1.10.4-otp-22
asdf install elixir 1.12.3-otp-24
asdf global elixir 1.12.3-otp-24

asdf plugin-add nodejs
asdf install nodejs 16.1.0
asdf global nodejs 16.1.0

git clone https://github.com/elixir-lsp/elixir-ls.git ~/dev/elixir-ls
pushd ~/dev/elixir-ls
mix deps.get
mix elixir_ls.release
popd

if [ $installed_garmin ]
then
  echo "Don't forget to remove the Garmin Express login item!"
fi
