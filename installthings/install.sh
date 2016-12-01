#!/bin/bash

here=`pwd`
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
    'terminator'
    'autojump'
    'tmux'
    'nethogs'
    'guake'
    'gitg'
    'geany'
    'vlc'
    'unity-tweak-tool'
    'shutter'
    'indicator-keylock'
    'typora'
    'calibre'
    'wiznote'
    'catfish'
    'papirus-gtk-icon-theme'
    'python-pip'
    'python3-pip'
    'caffeine-plus'
    'rar'
    'unrar'
    'mysql-client'
    'mysql-server'
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

# flux
echo "start installing flux..."
cd /tmp
git clone https://github.com/xflux-gui/xflux-gui.git
cd xflux-gui
python download-xflux.py
sudo python setup.py install
python setup.py install --user
cd $here

echo "done"
