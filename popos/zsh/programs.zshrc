# ASDF

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# DIRENV

eval "$(direnv hook zsh)"

# MONOREPO CD

eval "$(monorepo-cd --init m)"
