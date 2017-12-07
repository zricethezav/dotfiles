DOTFILES := $(shell pwd)
UNAME := $(shell uname)
all: pkgs bash tmux vim done sec
.PHONY: pkgs bash tmux vim git done sec

pkgs:
ifeq ($(UNAME),Linux)
	sudo apt-get install -y silversearcher-ag tmux transmission
endif
ifeq ($(UNAME),Darwin)
	brew install tmux transmission the_silver_searcher ctags 
endif
	echo Done installing packages
bash:
	mkdir $(HOME)/.marks
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
sec:
	$(shell chmod 755 sec/install.sh)
	$(shell sec/install.sh)
	ln -fs $(DOTFILES)/sec/scripts.sh ${HOME}/.sec/scripts.sh

done:
	chsh -s /bin/bash
