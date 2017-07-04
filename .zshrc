# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/root/.oh-my-zsh

# [zsh]
ZSH_THEME="robbyrussell"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
DIRSTACKSIZE=16

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

# [Go]
export PATH="$PATH:$GOPATH/bin"
export GOPATH=$HOME/Projects/go

# [virtualenv] 
export WORKON_HOME=~/Envs
source virtualenvwrapper.sh

# [aliases]
alias vim='/usr/bin/vim'
alias ds='dirs -v'      # Alias director stack
alias mkdir='mkdir -p'  # Create parent by default
alias ls='ls -h --color --group-directories-first'  # Add color to ls
alias ll='ls -lv --group-directories-first'         # Informative
alias la='ls -A'                                    # Show hidden files
alias lr='ll -R'                                    # Recursive ls.
alias lr='ll -R'                                    # Recursive ls.
alias lr='ll -R'                                    # Recursive ls.
alias lr='ll -R'                                    # Recursive ls.
alias lr='ll -R'                                    # Recursive ls.
alias lr='ll -R'                                    # Recursive ls.
alias lr='ll -R'                                    # Recursive ls.

## Larger Functions
# [(De)Compress]
function extract()
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

# [(De)Compress to target]
function extract_to()
{
  if [ -f $1 ]; then
    case $1 in 
      *.tar.bz2)  tar xvjf $1 -C $2    ;;
      *.tar.gz)   tar xvzf $1 -C $2    ;;
      *.bz2)      bunzip2 $1  -C $2    ;;
      *.rar)      unrar x $1  -C $2    ;;
      *.gz)       gunzip $1   -C $2    ;;
      *.tar)      tar xvf $1  -C $2    ;;
      *.tgz)      tar xvzf $1 -C $2    ;;
      *.zip)      unzip $1    -C $2      ;;
      *.Z)        uncompress $1 -C $2  ;;
      *.7z)       7z x $1 -C $2       ;;
      *)          echo "Don't know how to extract '$1'..."  ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# [Get IP (requires conn)]
function getip()
{
  in_ip=$(hostname -I | cut -d' ' -f1)
  ex_ip=$(wget http://ipinfo.io/ip -qO -)

  echo "internal ip: ${in_ip}"
  echo "external ip: ${ex_ip}"
}

