#!/bin/bash

# General
brew cask uninstall bitwarden
brew cask uninstall chromium
brew cask uninstall dropbox
brew cask uninstall firefox
brew cask uninstall font-fontawesome
brew cask uninstall keepingyouawake
brew cask uninstall libreoffice
brew cask uninstall riot
brew cask uninstall shifty
brew cask uninstall sonos
brew cask uninstall spotify
brew cask uninstall standard-notes

# Personal
brew cask uninstall garmin-express
# TODO: remove garmin login item
brew cask uninstall patchwork
brew cask uninstall steam

# Work
brew cask uninstall postico
brew cask uninstall slack
brew cask uninstall toggl
brew cask uninstall zoomus

# Development
chsh -s /bin/bash

emacs_app="$(nix eval nixpkgs.emacsMacport.outPath | tr -d '"')/Applications/Emacs.app"
emacs_icon="$emacs_app/Contents/Resources/Emacs.icns"
sudo rm $emacs_icon
sudo mv "$emacs_icon.bk" $emacs_icon
touch $emacs_app
sudo killall Dock
sudo killall Finder

rm -rf ~/.emacs.d
rm -rf ~/dev

brew cask uninstall dash
brew cask uninstall docker
brew cask uninstall font-source-code-pro
brew cask uninstall insomnia
brew cask uninstall vscodium

# Uninstall Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"

# Uninstall Nix
sudo rm -rf /nix
rm -rf ~/.nix*

# Uninstall XCode Command Line Tools
sudo rm -rf /Library/Developer/CommandLineTools

# TODO Enable SIP and uninstall XCode

