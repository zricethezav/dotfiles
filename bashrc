
# [ prompt ]
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# [ extras ]
logit() {
    if [[ ! -f ~/.logit ]]; then
        touch ~/.logit
    fi

    if [[ -z $1 ]]; then
        vim ~/.logit_tmp +startinsert
        if [[ ! -f ~/.logit_tmp ]]; then
            echo "Log entry cancelled"
            return
        fi
        sed -i -e $'s/^/    /' ~/.logit_tmp
        echo -e "[ `date '+%Y-%m-%d %H:%M:%S'` ]\n$(cat ~/.logit_tmp)" > ~/.logit_tmp
        cat ~/.logit_tmp ~/.logit >> ~/.logit_merge; mv ~/.logit_merge ~/.logit
        rm ~/.logit_tmp
    elif [[ $1 = "head" ]]; then
        head ~/.logit
    elif [[ $1 = "tail" ]]; then
        tail ~/.logit
    elif [[ $1 = "cat" ]]; then
        cat ~/.logit
    fi
}

# [ Transmission (torrents) TODO getopts ] 
tsm() {
    transmission-remote -l
}
tsm-daemon() {
    transmission-daemon
}
tsm-add() { 
    transmission-remote --add "$1"
}
tsm-clearcompleted() {
        transmission-remote -l | grep 100% | grep Done | \
        awk '{print $4}' | xargs -n 1 -I % transmission-remote -t % -r
}
tsm-quit() { 
    killall transmission-daemon
}
tsm-purge() { 
    transmission-remote -t"$1" --remove-and-delete
} 

# [ Tmux ]
t-n() {
    tmux new -s "$1"
}
t-ls() {
    tmux ls
}
t-kill-all() {
    tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
}
t-kill() {
    tmux kill-session -t "$1"
}
t-d() {
    tmux detach
}
t-a() {
    tmux a -t "$1"
}

# [ fzf ]
fzfp() {
    fzf --preview 'head -100 {}'
}
fzfv() {
    vim $(fzf)
} # --files: List files that would be searched but do not search

# [ go ]
export GOPATH=$HOME/Go

# [ pythons ]
export PYTHONPATH=$HOME/lib/python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh

export PATH=$PATH:/usr/local/bin:/usr/local/etc/bash_completion.d:/usr/local:/usr/local/include:/usr/local/sbin:$GOPATH/bin:$GOPATH:/Library/go_appengine/:/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/Cellar

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
