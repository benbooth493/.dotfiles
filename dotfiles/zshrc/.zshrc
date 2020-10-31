export ZSH="$HOME/.oh-my-zsh"
plugins=()

source $ZSH/oh-my-zsh.sh

[ -f $HOME/.zshrc.vars ] && source $HOME/.zshrc.vars

unsetopt share_history

fpath=($fpath $HOME/.zsh/completion)

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

alias vim="nvim"
alias tree="tree -C"
alias cat="bat --plain --pager=never"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export STARSHIP_CONFIG=$HOME/.config/starship.toml
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
