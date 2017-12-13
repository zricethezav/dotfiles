DOTFILES := $(shell pwd)
UNAME := $(shell uname)
all: pkgs bash tmux vim git done 
.PHONY: pkgs bash tmux vim git done

pkgs:
ifeq ($(UNAME),Linux)
	sudo apt-get install -y silversearcher-ag tmux transmission
endif
ifeq ($(UNAME),Darwin)
	brew install transmission the_silver_searcher ctags bash-completion
	brew list tmux &>/dev/null || brew install tmux 
endif

bash:
	ln -fs $(DOTFILES)/bash/bash_aliases ${HOME}/.bash_aliases
	ln -fs $(DOTFILES)/bash/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/bash/bash_profile ${HOME}/.bash_profile
tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -fs $(DOTFILES)/vimrc ${HOME}/.vimrc
	vim +PlugInstall +qall
git:
ifeq ($(UNAME),Linux)
	sudo apt-get install -y silversearcher-ag tmux transmission
endif
ifeq ($(UNAME),Darwin)
	[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] || \
		wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -P \
		/usr/local/etc/bash_completion.d/
endif


done:
	chsh -s /bin/bash
