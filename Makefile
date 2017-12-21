DOTFILES := $(shell pwd)
UNAME := $(shell uname)
VIMVERSION := $(shell vim --version | head -1 | cut -d ' ' -f 5 | head -c 1 )
all: pkgs bash tmux vim git aws done 
.PHONY: pkgs bash tmux vim git aws done

pkgs:
ifeq ($(UNAME),Linux)
	sudo apt-get install -y silversearcher-ag tmux transmission ctags vim
endif
ifeq ($(UNAME),Darwin)
	brew install transmission the_silver_searcher ctags bash-completion
	brew list tmux &>/dev/null || brew install tmux 
	brew list vim &>/dev/null || brew install vim
endif

bash:
	ln -fs $(DOTFILES)/bash/bash_aliases ${HOME}/.bash_aliases
	ln -fs $(DOTFILES)/bash/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/bash/bash_profile ${HOME}/.bash_profile

tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf

vim:
ifeq ($(UNAME),Linux)
	if [ $(VIMVERSION) -lt 9 ]; then\
		sudo add-apt-repository -y ppa:jonathonf/vim;\
		sudo apt update;\
		sudo apt install vim;\
	fi
endif

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -fs $(DOTFILES)/vimrc ${HOME}/.vimrc
	vim +PlugInstall +qall

git:
ifeq ($(UNAME),Linux)
	[ -f /etc/bash_completion.d/git-completion.bash ] || \
		sudo wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -P \
		/etc/bash_completion.d/
endif
ifeq ($(UNAME),Darwin)
	[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] || \
		wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -P \
		/usr/local/etc/bash_completion.d/
endif

aws:
	@echo "Installing aws cli tool"
	$(shell pip install awscli --upgrade --user &>/dev/null)
	@echo "Done Installing aws cli tool"
	@echo "to install seperate profiles for fun and for work:\n\n\t aws configure --profile {profile_name}\n"

done:
	chsh -s /bin/bash
