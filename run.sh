#!/bin/bash

here=`pwd`
readonly here

echo -e "start update the system... \n"
echo "" > log/run_log.txt

# func : update the ubuntu apt
update_system() {
    sudo apt update;
    if [ $? == 0 ]
    then 
        echo "update system successfully" >> log/run_log.txt
    else
        echo "there are some problems when try to update system" >> log/run_log.txt
    fi
}
# func : upgrade the software
upgrade_system() {
    sudo apt upgrade;
    if [ $? == 0 ]
    then 
        echo "upgrade system successfully" >> log/run_log.txt
    else
        echo "there are some problems when try to upgrade system" >> log/run_log.txt
    fi
}
# install fonts
echo "start installing fonts...";
echo "start installing fonts" >> log/run_log.txt
cd fonts
chmod 755 fonts/fonts.sh
sudo sh fonts/fonts.sh
cd $here
if [ $? == 0 ]
then
    echo "fonts installed" >> log/run_log.txt
else
    echo "[!] some errors when install fonts" >> log/run_log.txt
fi
# add ppa
chmod 755 ppa/ppa.sh
sudo sh ppa/ppa.sh
# update && upgrade

update_system
upgrade_system

# install software icons themes

echo "start installing some software icons and themes..."
chmod 755 installthings/install.sh
sudo sh installthings/install.sh

# config zsh vim mythemes
cd config
chmod 755 config/config.sh
sudo sh config/config.sh 
cd $here
echo "ALL END"