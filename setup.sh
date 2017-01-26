#!/bin/bash

# the location of here
HERE=`pwd`


# add ppa by this
PPA=$HERE/res/ppa/ppa.sh
# my vim config
VIM=$HERE/res/vim/vimrc
# my zsh config
ZSH=$HERE/res/zsh/zshrc
# applications will be installed
APPS=$HERE/res/apps/apps
# fonts in there
FONTS=$HERE/res/font/Monaco
# theme
THEME=$HERE/res/themes/Ambiance_Mac
# vscode
VS_CODE=$HERE/res/vscode/*
# log wil be write into this file
LOGS=$HERE/setup_log


# clear log
echo "" > $LOGS


## print log
print_log()
{
    echo -e  "\033[0;31;1m LOGS: $1  \033[0m"
    echo LOGS: $1 >> $LOGS
}


## update && upgrade system
update_system()
{
    print_log "UPDATE SYSTEM..."
    sudo apt update
    if [ $? = 0 ] 
        then print_log "UPDATE SYSTEM SUCCESSFULLY"
    else
        print_log "ERROR WHEN UPDATE SYSTEM"
    fi
    sudo apt upgrade
    if [ $? = 0 ] 
        then print_log "UPGRADE SYSTEM SUCCESSFULLY" 
    else
        print_log "ERROR WHEN UPGRADE SYSTEM"
    fi
}


## config the vim
config_vim()
{
    print_log "CONFIG VIM..."
    mv ~/.vimrc ~/.vimrc.bck
    mv ~/.vim ~/.vim.bck

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp $VIM ~/.vimrc

    vim +PluginInstall +qall

    print_log "VIM DONE"
}


## config the zsh
config_zsh()
{
    print_log "CONFIG ZSH"
    mv ~/.zshrc ~/.zshrc.bck
    # oh my zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    cp $ZSH ~/.zshrc
    cd $HERE
    print_log "STARTING CHSH TO ZSH"
    chsh -s /bin/zsh
    
    if [ $? = 0 ] 
    then print_log "CHSH SUCCESSFULLY"
    else 
        print_log "ERROR WHEN CHSH"
    fi
}

## add ppa
add_ppa()
{
    print_log "ADD PPA..."
    sh $PPA
    cd $HERE
    print_log "ADD PPA DONE"
}


## config fonts
config_font()
{
    print_log "ADD MONACO AND YAHEI FONTS TO UBUNTU"
    sudo cp -r $FONTS /usr/share/fonts/
    cd /usr/share/fonts/Monaco
    sudo chmod 755 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    cd $HERE
    print_log "ADD MONACO AND YAHEI DONE"
}


## install applications
install_apps()
{
    # get application from app files
    applications=$(cat $APPS)

    print_log "INSTALL APPLICATIONS..."
    echo "\n"

    for app in $applications; do
        print_log "STARTING TO INSTALL $app"
        sudo apt install ${app}
        status=$?
        if [ $status = 0 ] 
        then
            print_log "SUCCESSFULLY INSTALLED"
            success_installed=`expr $success_installed + 1`
            print_log "[√]${app} WAS INSTALLED OR IT WAS EXIST"
        else
            print_log "ERROR WHEN INSTALL $app"
            false_installed=`expr $false_installed + 1`
            print_log "$app WAS NOT BE INATALLED"
        fi
    done

    # install information
    
    print_log "$success_installed APPLICATIONS WERE INSTALLED SUCCESSFULLY"
    print_log "$false_installed APPLICATIONS WERE NOT BE INSTALLED, PLEASE CHECK"

    # install flux to protect your eyes
    print_log "INSTALL flux"

    cd /tmp

    git clone https://github.com/xflux-gui/xflux-gui.git
    cd xflux-gui
    python download-xflux.py 
    sudo python setup.py install
    python setup.py install --user 
    cd $HERE

    print_log "INSTALL APPLICATIONS DONE"
}


## icons
config_icons()
{
    print_log "ADD ICON: PAPIRUS"

    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh

    print_log "ICONS CONFIG DONE"
}


## theme for Ambiance mac like
config_theme()
{
    print_log "ADD Ambiance_Mac THEME"
    print_log "CP Ambiance_Mac theme TO /usr/share/themes"
    sudo cp -r $THEME /usr/share/themes
}


## powerline font
powerline_fonts()
{
    print_log "ADD POWERLINE FONTS"
    
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh 
    cd $HERE
    rm -rf fonts
}


## vscode
config_vscode()
{
    print_log "CONDIF VS CODE"
    mkdir -p $HOME/.config/Code/User/
    cp $VS_CODE $HOME/.config/Code/User/ 
}

print_log "START CONFIGURE UBUNTU..."
print_log "input ./setup.sh -Q for help"

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
            echo "visual studio code"
            config_vscode
            echo "done";;

        9)
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

        \?)
            echo "------------------------------HELP------------------------------------"
            echo "----------------------------------------------------------------------"
            echo "|-0  install applications                                            |"
            echo "|-1  install monaco && micosoft yahei fonts                          |"
            echo "|-2  config zsh                                                      |"
            echo "|-3  config vim                                                      |"
            echo "|-4  config icons                                                    |"
            echo "|-5  install powerline fonts                                         |"
            echo "|-6  add ppa                                                         |"
            echo "|-7  Ambiance_Mac theme                                              |"
            echo "|-8  visual studio code                                              |"    
            echo "|-9  do all for your system, if your system is new one               |"
            echo "----------------------------------------------------------------------"
            echo "------------------------------NOTE------------------------------------"
            echo "|if you use zsh && vim, you should install powerline fonts at first  |"
            echo "|if you want to install apps, you should add ppa at first            |"
            echo "----------------------------------------------------------------------"
            echo "bye";;
    esac
done
