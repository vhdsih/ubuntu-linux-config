#!/bin/bash


# zsh

git clone https://github.com/caiogondim/bullet-train-oh-my-zsh-theme.git
cd bullet-train-oh-my-zsh-theme
mv ~/.zshrc ~/.zshrc_back
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
cp my_zshrc ~/.zshrc
cp bullet-train.zsh-theme ~/.oh-my-zsh/themes/
cd -
chsh -s /bin/zsh

# vim
mv ~/.vim .vim_backup
mv ~/.vimrc .vimrc_backup

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp my_vimrc ~/.vimrc
vim +PluginInstall +qall


# powerline font 
git clone https://github.com/powerline/fonts.git
cd font
./install.sh 
cd -
rm -rf font 


# icons
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh
