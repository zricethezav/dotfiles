export ZSH="/Users/zacharyrice/.oh-my-zsh"
plugins=(git)

export EDITOR=nvim
export VISUAL=nvim
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin
export TERM=screen-256color

source ~/.config/zsh/.functions
source ~/.config/zsh/.alias
source ~/.config/zsh/.gitlab

source ~/.zsh_creds
source $ZSH/oh-my-zsh.sh

PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
