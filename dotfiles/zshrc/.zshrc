source <(kubectl completion zsh)
fpath=($fpath $HOME/.zsh/completion)

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export PATH=$HOME/.gloo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export EDITOR=nvim

alias vim="nvim"
alias tree="tree -C"
alias cat="bat --plain --pager=never"
alias k="kubectl"
alias argocd="argocd --grpc-web"
alias lg="lazygit"

alias ls='exa'
alias l='exa --long -bF --git'
alias ll='exa --long -b --grid -F --git'
alias llm='exa --long -b --grid -d --git --sort=modified'
alias la='exa --long -bhHigUmuSa --time-style=long-iso --git --color-scale'
alias lx='exa --long -bhHigUmuSa@ --time-style=long-iso --git --color-scale'
alias lS='exa -1'
alias lt='exa --tree --level=2'

#eval "$(starship init zsh)"
#eval "$(oh-my-posh init zsh --config ~/.pure.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.bubbles.omp.json)"
enable_poshtransientprompt

export TF_VAR_vault_token_mesh=(cat ~/.vault-token)
export TF_VAR_vault_token_monitoring=(cat ~/.vault-token)
export TF_VAR_argocd_token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJiYi10ZXJyYWdydW50IiwiaWF0IjoxNjUyNzc1NDA1LCJpc3MiOiJhcmdvY2QiLCJuYmYiOjE2NTI3NzU0MDUsInN1YiI6Im1lc2g6YXBpS2V5In0.6uAKrwBuJLsaA2WTbTAxm1mhdCqReQ61064XWw-hT1A"
