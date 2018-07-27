#!/bin/bash
# author: zach rice

# links
BASE=$(pwd)
mkdir ${HOME}/.marks
ln -fs ${BASE}/bashrc ${HOME}/.bashrc
ln -fs ${BASE}/bash_profile ${HOME}/.bash_profile
ln -fs ${BASE}/bash_aliases ${HOME}/.bash_aliases
ln -fs ${BASE}/tmux.conf ${HOME}/.tmux.conf

# mac
if [ "$(uname -s)" = 'Darwin' ]; then
    [ -z "$(which brew)" ] &&
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew install git vim wget fzf tree tmux graphviz transmission bash-completion
    brew cask install virtualbox virtualbox-extension-pack vagrant flux spectacle
    # [ -f /usr/local/etc/bash_completion.d/git-completion.bash ] || \
    #     wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -P \
    #     /usr/local/etc/bash_completion.d/
else
# linux
    sudo apt install -y git vim tmux wget transmission virtualbox virtualbox-ext-pack
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    sudo -y ~/.fzf/install
    # [ -f /etc/bash_completion.d/git-completion.bash ] || \
    #     sudo wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -P \
    #     /etc/bash_completion.d/
fi

git config --global user.email "zricer@protonmail.com"
git config --global user.name "zach rice"

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf

# vim
mkdir -p ~/.vim/autoload
curl --insecure -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
mv -v ~/.vimrc ~/.vimrc.old 2> /dev/null
ln -sf $BASE/vimrc ~/.vimrc

vim +PlugInstall +qall
