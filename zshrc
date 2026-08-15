# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # prompt itself comes from starship (see below)
plugins=(git autojump)
source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

# fzf keybindings and completion (ctrl-r history, ctrl-t files)
command -v fzf > /dev/null && source <(fzf --zsh)

# Custom aliases
[ -f ~/.aliases ] && source ~/.aliases

# Prompt
eval "$(starship init zsh)"

# Runtime version manager (node, etc.)
eval "$(mise activate zsh)"
