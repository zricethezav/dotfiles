#!/usr/bin/env bash

# [install]
# list of things to install:
#   - transmission (brew or apt)
#   - tmux (brew or apt)
#   - vim8 (brew or apt)
#   - zsh (wget (do this last))
#   - python
#   - virtualenv
#   - virtualenvwrapper
#   - ag (used in fzf for file searching)

## [Head]
targets=(
    'zsh'
    'vim'
    'tmux'
    'git'
    'python'
    'silversearcher-ag'
    'transmission'
)


install(){
    if [[ $platform == 'mac' ]]; then
        brew install $1
    else
        sudo apt-get -y install $1
    fi
}

# Determine if we want to use brew or apt
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    echo "Linux detected, using apt for installs"
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
    echo "MacOS detected, using brew for installs"
fi

# Install packages from brew or apt
echo ""
echo -e "\033[35m==> \033[37mZach's installer, setting up your system for happy development...\033[0m"
echo -e "Installing items: ${targets[@]}"

for target in ${targets[@]}
do
    echo ""
    echo -e "\033[35m==> \033[37mInstalling $target\033[0m"

    if [[ $platform == 'linux' && $target == 'vim' ]]; then
        # special install for vim8
        sudo add-apt-repository -y ppa:jonathonf/vim
        sudo apt -y update
        sudo apt -y install vim
    elif [[ $platform == 'mac' ]] && [[ $target == 'zsh' ]]; then
        brew install zsh zsh-completions
    elif [[ $platform == 'mac' ]] && [[ $target == 'silversearcher-ag' ]]; then
        brew install the_silver_searcher
    else
        install $target
    fi
done


# Install dotfiles
# vim-plug
echo ""
echo -e "\033[35m==> \033[37mCloning and installing dotfiles $target\033[0m"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/zricethezav/dotfiles
sudo cp dotfiles/tmux.conf ~/.tmux.conf
sudo cp dotfiles/vimrc ~/.vimrc

# Switch to Oh-my-zsh
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo cp dotfiles/zshrc ~/.zshrc
sudo sh zsh

rm -rf dotfiles
