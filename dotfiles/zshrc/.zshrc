# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -f $HOME/.zshrc.vars ] && source $HOME/.zshrc.vars

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
typeset POWERLEVEL9K_SHORTEN_STRATEGY=truncate_from_right
typeset POWERLEVEL9K_DISABLE_RPROMPT=true

autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

source <(kubectl completion zsh)
fpath=($fpath $HOME/.zsh/completion)

source <(flux completion zsh)

export FZF_DEFAULT_COMMAND="rg --files-with-matches --hidden '.' --glob '!.git'"

if [[ -f /usr/local/share/chtf/chtf.sh ]]; then
    source /usr/local/share/chtf/chtf.sh
fi

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

alias vim="nvim"
alias tree="tree -C"
alias cat="bat --plain --pager=never"
alias k="kubectl"
alias ls="exa --icons"
alias ll="exa -lh --icons --git"
alias la="exa -alh --icons --git"
alias argocd="argocd --grpc-web"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

PATH="/Users/ben.booth/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/ben.booth/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/ben.booth/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/ben.booth/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ben.booth/perl5"; export PERL_MM_OPT;

export PATH="$HOME/.poetry/bin:$PATH"

if [ -e /Users/ben.booth/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ben.booth/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

alias lg='lazygit'
export PATH=$HOME/.config/nvcode/utils/bin:$PATH

