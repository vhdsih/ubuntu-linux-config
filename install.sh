#!/bin/bash

# the location of here
HERE=`pwd`

# add ppa by this
PPA=$HERE/res/ppa/ppa.sh
# my vim config
VIM=$HERE/res/vim/my_vimrc
# my zsh config
ZSH=$HERE/res/zsh/my_zshrc
# applications will be installed
APPS=$HERE/res/apps/apps.txt
# fonts in there
FONTS=$HERE/res/font/Monaco
# theme
THEME=$HERE/res/themes/Ambiance_Mac
# vscode
VS_CODE=$HERE/res/vscode/*
# log wil be write into this file
LOGS =$HERE/log.txt


# clear log
echo "" > $LOGS

## update && upgrade system
update_system()
{
    sudo apt update
    if [ $? = 0 ] 
        then echo "update the system successfully" >> $LOGS 
    else
        echo "have problems when update the system" >> $LOGS
    fi
    sudo apt upgrade
    
    if [ $? = 0 ] 
        then echo "upgrade the system successfully" >> $LOGS 
    else
        echo "have problems when upgrade the system" >> $LOGS
    fi
}
## config the vim
config_vim()
{
    echo "start config vim..." >> $LOGS
    mv ~/.vimrc ~/.vimrc_backup
    mv ~/.vim ~/.vim_backup

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp $VIM ~/.vimrc
    vim +PluginInstall +qall

    echo "VIM DONE!" >> $LOGS
}
## config the zsh
config_zsh()
{
    echo "start config zsh..." >> $LOGS
    git clone https://github.com/caiogondim/bullet-train-oh-my-zsh-theme.git
    cd bullet-train-oh-my-zsh-theme
    mv ~/.zshrc ~/.zshrc_back
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    cp $ZSH ~/.zshrc
    cp bullet-train.zsh-theme ~/.oh-my-zsh/themes/
    cd $HERE
    chsh -s /bin/zsh
}
## add ppa
add_ppa()
{
    echo "start add ppas... " >> $LOGS
    sh $PPA
    cd $HERE
    echo "ADD PPAS DONE" >> $LOGS
}
## config fonts
config_font()
{
    echo "start config fonts..." >> $LOGS
    sudo cp -r $FONTS /usr/share/fonts/
    cd /usr/share/fonts/Monaco
    sudo chmod 755 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    cd $HERE
    echo "CONFIG FONTS DONE!" >> $LOGS
}
## install applications
install_apps()
{
    # get application from app files
    applications=$(cat $APPS)

    echo "INSTALL APPLICATIONS..." >> $LOGS
    echo "\n"

    for app in $applications; do
        echo "start installing ${app} ..."
        sudo apt install ${app}
        status=$?
        if [ $status = 0 ] 
        then
            echo "success install ${app} or it has been exist"
            success_installed=`expr $success_installed + 1`
            echo "[√]${app} was installed or it was exist." >> $LOGS
        else
            echo "installation aborted\n"
            false_installed=`expr $false_installed + 1`
            echo "[x] ${app} was not installed." >> $LOGS
        fi
    done

    # install information
    echo "$success_installed things was installed" >> $LOGS
    echo "$false_installed sofwares was not installed" >> $LOGS
    echo "$success_installed applications install successfully"
    echo "$false_installed applications can not be installed, please check!!!"

    # install flux to protect your eyes
    echo "start installing flux..."
    echo "start installing flux..." >> $LOGS

    cd /tmp
    git clone https://github.com/xflux-gui/xflux-gui.git
    cd xflux-gui
    python download-xflux.py 
    sudo python setup.py install
    python setup.py install --user 
    cd $HERE

    echo "installing flux finished\n"
    echo "done" >> $LOGS
    echo "INSTALL APPLICATIONS DONE"
}
## icons
config_icons()
{
    echo "start config icons..." >> $LOGS

    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh

    echo "ICONS CONFIG DONE" >> $LOGS
}
## theme for Ambiance mac like
config_theme()
{
    echo "Ambiance_Mac theme"
    echo "cp Ambiance_Mac theme to /usr/share/themes" >> $LOGS
    sudo cp -r $THEME /usr/share/themes
}
## powerline font
powerline_fonts()
{
    echo "start config powerline fonts" >> $LOGS
    
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh 
    cd $HERE
    rm -rf fonts
}
## vscode
config_vscode()
{
    echo "config vscode, you must install vscode before"
    cp $VS_CODE /home/me/.config/Code/User/ 
}
while getopts 012345678A option
do
    case "$option" in
        0)
            echo "install application on your ubuntu" 
            update_system
            install_apps
            echo "done";;

        1)
            echo "install Monaco && microsoft yahei fonts on your ubuntu"
            config_font
            echo "done";;
        2)
            echo "config zsh on your ubuntu"
            config_zsh
            echo "done";;
        3)
            echo "config vim on your ubuntu"
            config_vim
            echo "done";;
        4) 
            echo "config icons on your ubuntu"
            config_icons
            echo "done";;
        5) 
            echo "install poerline fonts on your ubuntu"
            powerline_fonts
            echo "done";;
        6)
            echo "add ppa for your system"
            add_ppa
            echo "done";;
        7)
            echo "Ambiance_Mac theme"
            config_theme
            echo "done";;
        8)
            echo "do all"
            add_ppa
            update_system
            install_apps
            config_font
            powerline_fonts
            config_vim
            config_zsh
            config_icons
            config_theme
            echo "done";;
        A)
            echo "config vscode"
            config_vscode
            echo "done";;

        \?)
            echo "--help--"
            echo "-0  install applications"
            echo "-1  install monaco && micosoft yahei fonts"
            echo "-2  config zsh"
            echo "-3  config vim"
            echo "-4  config icons"
            echo "-5  install powerline fonts"
            echo "-6  add ppa"
            echo "-7  Ambiance_Mac theme"
            echo "-8  do all for your system, if your system is new one"
            echo "-----"
            echo "if you use zsh && vim, you should install powerline fonts at first"
            echo "if you want to install apps, you should add ppa at first"
            echo "bye";;
    esac
done
