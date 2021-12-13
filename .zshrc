#!/bin/bash
export ZSH="/Users/zacharyrice/.oh-my-zsh"

# BASICS
export TERM=xterm-256color alacritty
export EDITOR=nvim
export VISUAL=nvim
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/node/bin
export PATH=/Users/zacharyrice/.rbenv/shims:/Users/zacharyrice/.rbenv/bin:/usr/local/opt/postgresql@10/bin:/Users/zacharyrice/.rbenv/shims:/Users/zacharyrice/.rbenv/bin:/usr/local/opt/postgresql@10/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/opt/X11/bin:/Users/zacharyrice/.rbenv/shims:/Users/zacharyrice/.rbenv/bin:/usr/local/opt/postgresql@10/bin:/Users/zacharyrice/.sdkman/candidates/java/current/bin:/Users/zacharyrice/.cargo/bin:/Users/zacharyrice/Go/bin:/Users/zacharyrice/.fzf/bin:/Users/zacharyrice/Go/bin:/Users/zacharyrice/Go/bin:/usr/local/opt/node/bin

# ALIASES
alias vim='nvim'
alias vi='nvim'
alias v='f -e nvim'
alias bn='git checkout -B'
alias cpdir='cp -a'
alias ds='dirs -v'
alias df='df -kTh'
alias sp='source ~/.zshrc'
alias sf='l | fzf'

# TODO use AGE or git-crypt for these
source ~/.config/zsh/.gitlab
source ~/.config/zsh/.reddit
source ~/.config/zsh/.github
source ~/.zsh_creds

source $HOME/.cargo/env
source $ZSH/oh-my-zsh.sh

# TMUX
function tn() {
    tmux new -s "$1"
}
function tls() {
    tmux ls
}
function tk-all() {
    tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
}
function tk() {
    tmux kill-session -t "$1"
}
function td() {
    tmux detach
}
function ta() {
    tmux a -t "$1"
}
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

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
