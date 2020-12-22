# [ Linkage ]
# this assumes dotfiles are cloned to ~/dotfiles and probably
# assumes you are using macos
ln -s -f ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s -f ~/dotfiles/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf

cp .gitconfig-work ~/.gitconfig-work
ln -s -f ~/dotfiles/.gitconfig ~/.gitconfig
