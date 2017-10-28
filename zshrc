export ZSH=/Users/Zach/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

DIRSTACKSIZE=16

# [aliases]
alias ds='dirs -v'      # Alias director stack
alias mkdir='mkdir -p'  # Create parent by default

# [Transmission] 
tsm() {transmission-remote -l;}
tsm-daemon() {transmission-daemon;}
tsm-altspeedenable() { transmission-remote --alt-speed ;}   # limit bandwidth
tsm-altspeeddisable() { transmission-remote --no-alt-speed ;}   # dont limit bandwidth
tsm-add() { transmission-remote --add "$1" ;}
tsm-pause() {transmission-remote -t "$1" --stop ;}
tsm-remove() {transmission-remote -t "$1" --remove;}
tsm-start() {transmission-remote -t "$1" --start;}
tsm-clearcompleted() {
        transmission-remote -l | grep 100% | grep Done | \
        awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % -r ;}
tsm-quit() { killall transmission-daemon ;}
tsm-purge() { transmission-remote -t"$1" --remove-and-delete ;} # delete data also
tsm-info() { transmission-remote -t"$1" --info ;}
tsm-speed() { while true;do clear; transmission-remote -t"$1" -i | grep Speed;sleep 1;done ;}
tsm-ncurse() { transmission-remote-cli ;}

# [Tmux]
t-n() {tmux new -s "$1";}
t-ls() {tmux ls;}
t-kill-all() {tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill;}
t-kill() {tmux kill-session -t "$1";}
t-d() {tmux detach ; }
t-a() {tmux a -t "$1"; }

# [fzf]
fzfp() {fzf --preview 'head -100 {}';}
fzfv() {vim $(fzf)}# --files: List files that would be searched but do not search

# [go]
export GOPATH=$HOME/Go

# [pythons]
export PYTHONPATH=$HOME/lib/python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh

export PATH=$PATH:/usr/local/bin:/usr/local/etc/bash_completion.d:/usr/local:/usr/local/include:/usr/local/sbin:$GOPATH/bin:$GOPATH:/Library/go_appengine/:/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/Cellar

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
