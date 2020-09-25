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
brew tap d12frosted/emacs-plus

# Window Management
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai
brew install cmacrae/formulae/spacebar

sudo yabai --install-sa

brew services start skhd
brew services start yabai
brew services start spacebar

killall Dock

# General
brew cask install bitwarden
brew cask install chromium
brew cask install cryptomator
brew cask install dropbox
brew cask install element
brew cask install firefox
brew cask install font-fontawesome
brew cask install keepingyouawake
brew cask install libreoffice
brew cask install maccy
brew cask install shifty
brew cask install sonos
brew cask install spotify
brew cask install standard-notes

# Home
read -p "Install home-specific software? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew cask install backblaze
  brew cask install garmin-express
  installed_garmin=true
  brew cask install patchwork
  brew cask install steam
fi

# Work
read -p "Install work-specific software? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew cask install postico
  brew cask install slack
  brew cask install toggl-track
  brew cask install zoomus
fi

# Development
brew cask install dash
brew cask install docker
brew cask install font-source-code-pro
brew cask install iterm2
brew cask install postman
brew cask install vscodium

brew install coreutils curl direnv git pre-commit terraform tmux vim wget wxmac
brew install asdf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
pushd ~/.emacs.d
git checkout develop
popd
brew install emacs-plus --with-no-titlebar --with-spacemacs-icon
ln -s /usr/local/opt/emacs-plus@27/Emacs.app /Applications

asdf plugin-add erlang
asdf install erlang 21.3.8.17
asdf install erlang 23.1
asdf global erlang 23.1

asdf plugin-add elixir
asdf install elixir 1.8.2-otp-21
asdf install elixir 1.10.4-otp-23
asdf global elixir 1.10.4-otp-23

asdf plugin-add nodejs
asdf install nodejs 11.14.0
asdf install nodejs 14.12.0
asdf global nodejs 14.12.0

git clone https://github.com/elixir-lsp/elixir-ls.git ~/dev/elixir-ls
pushd ~/dev/elixir-ls
mix deps.get
mix elixir_ls.release
popd

chsh -s /bin/zsh

wget -O $ZSH_CUSTOM/themes/pi.zsh-theme https://raw.githubusercontent.com/tobyjamesthomas/pi/master/pi.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ $installed_garmin ]
then
  echo "Don't forget to remove the Garmin Express login item!"
fi
