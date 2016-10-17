#!/bin/bash

# mytheme

sudo cp -r ../resource/MyTheme /usr/share/themes

# zsh
mv ~/.zshrc ~/.zshrc_back
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
cp my_zshrc ~/.zshrc

# vim
sh spf13-vim.sh





