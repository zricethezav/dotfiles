export ZSH="/Users/zacharyrice/.oh-my-zsh"
plugins=(git)

export EDITOR=nvim
export VISUAL=nvim
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export TERM=screen-256color

# [ marks ]
export MARKPATH=$HOME/.marks
function jump {
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
  mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
  rm -i "$MARKPATH/$1"
}
function marks {
  \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
function j {
  jump $1
}
function m {
  mark $1
}

# [ tmux ]
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

# [ torrents ]
function tsm() {
    transmission-remote -l
}
function tsm-daemon() {
    transmission-daemon
}
function tsm-add() {
    transmission-remote --add "$1"
}
function tsm-clearcompleted() {
        transmission-remote -l | grep 100% | grep Done | \
        awk '{print $4}' | xargs -n 1 -I % transmission-remote -t % -r
}
function tsm-quit() {
    killall transmission-daemon
}
function tsm-purge() {
    transmission-remote -t"$1" --remove-and-delete
}

# [ fzf ]
function fzfp() {
    fzf --preview 'head -100 {}'
}
function fzfv() {
    nvim $(fzf)
}
function fd() {
    local dir dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}

# [ general ]
function vd() {
    cp ~/.config/vimspectors/"$1"/vimspector.json .vimspector.json
}
function ghcfg() {
    echo '[user]
    name = zricethezav
    email = zricer@protonmail.com' >> $PWD/.git/config
}

# [ aliases ]
alias vim='nvim'
alias bn='git checkout -B'
alias b='git branch'
alias gc='git checkout'
alias gs='git status'
alias cpdir='cp -a'
alias ds='dirs -v'
alias df='df -kTh'
alias sp='source ~/.zshrc'
alias sf='l | fzf'
alias cat='bat'

source ~/.zsh_creds
source ~/.zsh_gitlab
source $ZSH/oh-my-zsh.sh

PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/postgresql@10/bin:/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
