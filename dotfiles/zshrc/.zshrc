[ -f $HOME/.zshrc.vars ] && source $HOME/.zshrc.vars

autoload -Uz compinit
compinit

unsetopt share_history

source <(kubectl completion zsh)
fpath=($fpath $HOME/.zsh/completion)

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

alias vim="nvim"
alias tree="tree -C"
alias cat="bat --plain --pager=never"
alias k="kubectl"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export STARSHIP_CONFIG=$HOME/.config/starship.toml
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH="/Users/ben.booth/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/ben.booth/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/ben.booth/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/ben.booth/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ben.booth/perl5"; export PERL_MM_OPT;

export PATH="$HOME/.poetry/bin:$PATH"

