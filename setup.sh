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
brew cask install shifty
brew cask install sonos
brew cask install spotify
brew cask install spotify-now-playing
brew cask install standard-notes

# Home
read -p "Install home-specific software? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  installed_garmin=true
  brew cask install garmin-express
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
  brew cask install toggl
  brew cask install zoomus
fi

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

if [ $installed_garmin ]
then
  echo "Don't forget to remove the Garmin Express login item!"
fi
