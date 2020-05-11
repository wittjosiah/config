#!/bin/bash

# NOTE: run from ~/dev/config
# TODO: Disable SIP and install XCode

# Install XCode Command Line Tools
xcode-select --install

# Link Config
mkdir ~/.nixpkgs
ln -s ~/dev/config/darwin-configuration.nix ~/.nixpkgs/darwin-configuration.nix

# Install Nix
curl -L https://nixos.org/nix/install | sh
. ~/.nix-profile/etc/profile.d/nix.sh

# home-manager
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# nix-darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts

# General
brew cask install bitwarden
brew cask install chromium
brew cask install dropbox
brew cask install firefox
brew cask install keepingyouawake
brew cask install libreoffice
brew cask install riot
brew cask install sonos
brew cask install spotify
brew cask install spotify-now-playing
brew cask install standard-notes

# Personal
brew cask install garmin-express
# TODO: remove garmin login item
brew cask install patchwork
brew cask install steam

# Work
brew cask install postico
brew cask install slack
brew cask install toggl
brew cask install zoomus

# Development
chsh -s /run/current-system/sw/bin/zsh

git clone https://github.com/Shopify/comma.git ~/dev/comma
pushd ~/dev/comma
nix-env -i -f .
popd

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
pushd ~/.emacs.d
git checkout develop
popd
git clone https://github.com/nashamri/spacemacs-logo.git ~/dev/spacemacs-logo
emacs_app="$(nix eval nixpkgs.emacsMacport.outPath | tr -d '"')/Applications/Emacs.app"
emacs_icon="$emacs_app/Contents/Resources/Emacs.icns"
sudo mv $emacs_icon "$emacs_icon.bk"
sudo cp ~/dev/spacemacs-logo/spacemacs.icns $emacs_icon
touch $emacs_app
sudo killall Dock
sudo killall Finder

brew cask install dash
brew cask install docker
brew cask install font-source-code-pro
brew cask install insomnia
brew cask install vscodium
