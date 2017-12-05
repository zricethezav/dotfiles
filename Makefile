DOTFILES := $(shell pwd)
UNAME := $(shell uname)
all: pkgs bash tmux vim
.PHONY: pkgs bash tmux vim git

pkgs:
ifeq ($(UNAME),Linux)
	sudo apt-get install -y silversearcher-ag tmux transmission
endif
ifeq ($(UNAME),Darwin)
	brew install tmux transmission 
endif
	echo Done installing packages
bash:
	ln -fs $(DOTFILES)/bash_aliases ${HOME}/.bash_aliases
	ln -fs $(DOTFILES)/bashrc ${HOME}/.bashrc
tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -fs $(DOTFILES)/vimrc ${HOME}/.vimrc
