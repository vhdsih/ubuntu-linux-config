#!/bin/bash


# zsh
mv ~/.zshrc ~/.zshrc_back
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
cp my_zshrc ~/.zshrc
chsh -s /bin/zsh

# vim
sh spf13-vim.sh

cp vimrc.local ~/.vimrc.local
cp vimrc.before.local ~/.vimrc.before.local

# powerline font 
git clone https://github.com/powerline/fonts.git
cd font
./install.sh 
cd -
rm -rf font 


# icons
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh
