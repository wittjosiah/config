# USER CONFIGURATION

export PATH="$PATH:/home/jdw/.local/bin"
export PATH="$PATH:$(yarn global bin)"

export EDITOR="vim"
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"
export PROJECTS_DIR="/home/jdw/Code"
export WEB_EXT_FIREFOX="/usr/local/firefox_dev/firefox"

# HISTORY
# https://www.soberkoder.com/better-zsh-history/

export HISTFILESIZE=10000000000
export HISTSIZE=10000000000
export SAVEHIST=10000000000
export HISTFILE=~/.zsh_history

export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

setopt share_history
setopt hist_verify

