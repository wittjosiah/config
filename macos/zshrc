# OHMYZSH

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/Users/jdw/.oh-my-zsh"

ZSH_THEME="pi"
plugins=(asdf git osx zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# USER CONFIGURATION

export EDITOR='vim'
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"


# ANDROID

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/19.2.5345600
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


# GO

export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"


# ALIASES

alias ll='ls -la'
alias phx='iex -S mix phx.server'


# ASDF

. /usr/local/opt/asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit


# DIRENV

eval "$(direnv hook zsh)"


# ITERM2

# From https://apas.gr/2018/11/dark-mode-macos-safari-iterm-vim/
if [[ "$(uname -s)" == "Darwin" ]]; then
    godark() {
      val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
      if [[ $val != "Dark" ]]; then
        t
      fi
    }

    t() {
      if [[ $ITERM_PROFILE == "Light" ]]; then
        setprofile "Dark"
      else
        setprofile "Light"
      fi
    }

    setprofile() {
      if [ -n "$TMUX" ]
      then
        # Reference: https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it
        echo -ne "\033Ptmux;\033\033]1337;SetProfile=$1\007\033\\"
      else
        # Reference: https://www.iterm2.com/documentation-escape-codes.html
        echo -ne "\033]50;SetProfile=$1\a"
      fi

      export ITERM_PROFILE="$1"
    }

    godark
fi

# ADB-FASTBOOT

if [ -d "$HOME/.adb-fastboot/platform-tools" ] ; then
    export PATH="$HOME/.adb-fastboot/platform-tools:$PATH"
fi


# SECRETS

source .secrets.env
