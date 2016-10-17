#!/bin/bash

success_installed=0
false_installed=0
things=(
    'tree'
    'ranger'
    'git'
    'htop'
    'vim'
    'tlp'
    'zsh'
    'autojump'
    'tmux'
    'guake'
    'gitg'
    'vlc'
    'unity-tweak-tool'
    'shutter'
    'virtualbox'
    'indicator-keylock'
    'classicmenu-indicator'
    'albert'
    'typora'
    'calibre'
    'okular'
    'wiznote'
    'catfish'
    'papirus-gtk-icon-theme'
    'python-pip'
    'python3-pip'

)
echo "" > ../log/install_log.txt
echo "the number of the thing is ${#things[*]}"
echo "${#things[*]} things will be installed" >> ../log/install_log.txt

for thing in ${things[*]}; do
    echo ""
    echo "start installing ${thing}..."
    sudo apt install ${thing}
    status=$?
    if [ $status == 0 ] 
    then
        echo "success"
        success_installed=`expr $success_installed + 1`
        echo "[√]${thing} was installed or it was exist." >> ../log/install_log.txt
    else
        echo "installation aborted"
        false_installed=`expr $false_installed + 1`
        echo "[x] ${thing} was not installed." >> ../log/install_log.txt
    fi
done
echo "$success_installed things was installed" >> ../log/install_log.txt
echo "$false_installed sofwares was not installed" >> ../log/install_log.txt
echo "success: $success_installed"
echo "false: $false_installed"
echo "END"
