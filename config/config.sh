#!/bin/bash

# theme
echo "" > ../log/config.txt
sudo cp -r ../resource/MyTheme /usr/share/themes
if [ $? == 0 ]; then
    echo "install theme successfully" >> ../log/config.txt
else 
    echo "can not install theme" >> ../log/config.txt
fi

# zsh
mv ~/.zshrc ~/.zshrc_back
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
cp my_zshrc ~/.zshrc
chsh -s /bin/zsh

# vim
sh spf13-vim.sh





