# ASDF

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# ALACRITTY

LIGHT_COLOR='pencil_light.yaml'
DARK_COLOR='pencil_dark.yaml'

alias day="alacritty-colorscheme -V apply $LIGHT_COLOR"
alias night="alacritty-colorscheme -V apply $DARK_COLOR"
alias toggle="alacritty-colorscheme -V toggle $LIGHT_COLOR $DARK_COLOR"

# BITWARDEN

un () {
  bw get username $1 | pbcopy
}

pw () {
  bw get password $1 | pbcopy
}

totp () {
  bw get totp $1 | pbcopy
}

# DIRENV

eval "$(direnv hook zsh)"

# MONOREPO CD

eval "$(monorepo-cd --init m)"
