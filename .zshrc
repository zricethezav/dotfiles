#!/bin/bash
export ZSH="/Users/zacharyrice/.oh-my-zsh"

export EDITOR=nvim
export VISUAL=nvim
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export TERM=screen-256color

source ~/.config/zsh/.functions
source ~/.config/zsh/.alias
source ~/.config/zsh/.gitlab
source ~/.config/zsh/.reddit

source $HOME/.cargo/env

source ~/.zsh_creds

source $ZSH/oh-my-zsh.sh

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~%{$fg_bold[blue]%}$(parse_git_branch)%{$fg_bold[blue]%} % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
