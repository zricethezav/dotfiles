# [ torrents ]
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

# [ tmux ]
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
}

# [ archive utils ]
extract()
{
  if [ -f $1 ]; then
    case $1 in 
      *.tar.bz2)  tar xvjf $1    ;;
      *.tar.gz)   tar xvzf $1    ;;
      *.bz2)      bunzip2 $1     ;;
      *.rar)      unrar x $1     ;;
      *.gz)       gunzip $1      ;;
      *.tar)      tar xvf $1     ;;
      *.tgz)      tar xvzf $1    ;;
      *.zip)      unzip $1       ;;
      *.Z)        uncompress $1  ;;
      *.7z)       7z x $1        ;;
      *)          echo "Don't know how to extract '$1'..."  ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}
mkrar() { rar a    "${1%%/}.rar"     "${1%%/}/"; }
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
mkzip() { zip -r "${1%%/}.zip" "${1%%/}/"; }

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

# [ aliases ]
alias restart='sudo reboot'
alias shutdown='sudo halt'
alias apt-get='sudo apt-get'
alias fucking='sudo'
alias root='sudo su -'
alias sp='source ~/.bash_profile'
alias nerd='vim +NERDTree'
alias cpdir='cp -a'
alias ll='ls -lv --group-directories-first'
alias mkdir='mkdir -p'
alias ds='dirs -v'
alias df='df -kTh'
alias ctags='`brew --prefix`/bin/ctags'
alias gitags='ctags -R -f ./.git/tags .'
alias bn='git checkout -B'
alias b='git branch'
alias gc='git checkout'
alias bt='bt is king, dont you dare forget'
