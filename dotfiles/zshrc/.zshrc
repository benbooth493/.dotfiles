autoload -U promptinit; promptinit
autoload -Uz compinit; compinit

zstyle :prompt:pure:git:stash show yes

prompt purer

source <(kubectl completion zsh)
fpath=($fpath $HOME/.zsh/completion)

if [[ -f /usr/local/share/chtf/chtf.sh ]]; then
    source /usr/local/share/chtf/chtf.sh
fi

export FZF_DEFAULT_COMMAND="rg --files-with-matches --hidden '.' --glob '!.git'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias vim="lvim"
alias tree="tree -C"
alias cat="bat --plain --pager=never"
alias ls="exa --icons --git"
alias ll="exa -lh --icons --git"
alias la="exa -lha --icons --git"
alias lr="exa -lh --icons --git --tree"
alias k="kubectl"
alias argocd="argocd --grpc-web"
alias kcc="kubectl config current-context"
alias docker="podman"

export PATH=$HOME/.gloo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
eval "$(pyenv init --path)"
