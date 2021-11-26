# GENERAL

alias ll='ls -la'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# GIT

alias gs='git status'
alias gc='git commit'

alias gp='git push'
alias gpsu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD 2>/dev/null)'

alias grsh='git reset --soft HEAD~1'
alias grhu='git reset --hard @{u}'

alias prune="git fetch -p && (git checkout -q origin/master || git checkout -q origin/dev || git checkout -q origin/main); git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs git branch -D"

# ELIXIR

alias phx='iex -S mix phx.server'