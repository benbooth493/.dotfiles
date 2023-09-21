set fish_greeting

set --global fish_prompt_pwd_dir_length 2
set --global hydro_color_pwd $fish_color_error
set --global hydro_color_git $fish_color_command
set --global hydro_color_duration $fish_color_comment
set --global hydro_color_prompt $fish_color_keyword

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --export EDITOR nvim

alias vim nvim
alias e nvim
alias lg lazygit
alias k kubectl
alias ktx kubectx

alias ls exa
alias l 'exa --long -bF --git'
alias ll 'exa --long -bF --grid --git'
alias llm 'exa --long -bd --grid --git --sort=modified'
alias la 'exa --long -bhHigUmuSa --time-style=long-iso --git --color=auto'
alias lx 'exa --long -bhHigUmuSa@ --time-style=long-iso --git --color=auto'
alias lS 'exa -1'
alias lt 'exa --tree --level=2'


alias mfa 'ykman oath accounts code aws-identity'

