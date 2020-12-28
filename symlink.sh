# [ Linkage ]
# this assumes dotfiles are cloned to ~/dotfiles and probably
# assumes you are using macos.
# Use the link target as directions on where to place this files.
# This is a dumb installer so you gotta do some work.
ln -s -f ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s -f ~/dotfiles/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/.functions ~/.config/zsh/.functions
ln -s -f ~/dotfiles/.alias ~/.config/zsh/.alias
ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/.alacritty.yml ~/.alacritty.yml

ln -s -f ~/dotfiles/.gitignore ~/.gitignore
ln -s -f ~/dotfiles/.gitconfig-work ~/.gitconfig-work
ln -s -f ~/dotfiles/.gitconfig ~/.gitconfig
