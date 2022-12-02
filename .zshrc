# completion
autoload -Uz compinit && compinit

# plugins
plugins=(git fzf-tab)

# path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# term
export EDITOR=nvim
export VISUAL=nvim

# aliases
alias vim='nvim'
alias vi='nvim'
alias v='f -e nvim'
alias bn='git checkout -B'
alias cpdir='cp -a'
alias ds='dirs -v'
alias df='df -kTh'
alias sp='source ~/.zshrc'
alias sf='l | fzf'
alias ls='ls -G'
alias l='ls -G -l -a'

# tmux
function tn() {tmux new -s "$1"}
function tls() {tmux ls}
function tk-all() {tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill}
function tk() {tmux kill-session -t "$1"}
function td() {tmux detach}
function ta() {tmux a -t "$1"}

# prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%F{green}$(parse_git_branch) %F{reset}'

# navigation
eval "$(fasd --init auto)"

# paths
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin:$HOME/.cargo/bin:$HOME/Library/Python/3.8/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/.local/bin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

