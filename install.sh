#!/bin/bash
HERE=`pwd`


# the location of the res
PPA=$HERE/res/ppa/ppa.sh
VIM=$HERE/res/vim/my_vimrc
ZSH=$HERE/res/zsh/my_zshrc
APPS=$HERE/res/apps/apps.txt
FONTS=$HERE/res/font/Monaco

echo "" > log.txt

## update && upgrade system
update_system()
{
    sudo apt update
    if [ $? = 0 ] 
        then echo "update the system successfully" >> log.txt 
    else
        echo "have problems when update the system" >> log.txt
    fi
    sudo apt upgrade
    
    if [ $? = 0 ] 
        then echo "upgrade the system successfully" >> log.txt 
    else
        echo "have problems when upgrade the system" >> log.txt
    fi
}
## config the vim
config_vim()
{
    echo "start config vim..." >> log.txt
    mv ~/.vimrc ~/.vimrc_backup
    mv ~/.vim ~/.vim_backup

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp $VIM ~/.vimrc
    vim +PluginInstall +qall

    echo "VIM DONE!" >> log.txt
}
## config the zsh
config_zsh()
{
    echo "start config zsh..." >> log.txt
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
    echo "start add ppas... " >> log.txt
    sh $PPA
    cd $HERE
    echo "ADD PPAS DONE" >> log.txt
}
## config fonts
config_font()
{
    echo "start config fonts..." >> log.txt
    sudo cp -r $FONTS /usr/share/fonts/
    cd /usr/share/fonts/Monaco
    sudo chmod 755 *
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    cd $HERE
    echo "CONFIG FONTS DONE!" >> log.txt
}
## install applications
install_apps()
{
    # get application from app files
    applications=$(cat $APPS)

    echo "INSTALL APPLICATIONS..." >> log.txt
    echo "\n"

    for app in $applications; do
        echo "start installing ${app} ..."
        sudo apt install ${app}
        status=$?
        if [ $status = 0 ] 
        then
            echo "success install ${app} or it has been exist"
            success_installed=`expr $success_installed + 1`
            echo "[√]${app} was installed or it was exist." >> log.txt
        else
            echo "installation aborted\n"
            false_installed=`expr $false_installed + 1`
            echo "[x] ${app} was not installed." >> log.txt
        fi
    done

    # install information
    echo "$success_installed things was installed" >> log.txt
    echo "$false_installed sofwares was not installed" >> log.txt
    echo "$success_installed applications install successfully"
    echo "$false_installed applications can not be installed, please check!!!"

    # install flux to protect your eyes
    echo "start installing flux..."
    echo "start installing flux..." >> log.txt

    cd /tmp
    git clone https://github.com/xflux-gui/xflux-gui.git
    cd xflux-gui
    python download-xflux.py 
    sudo python setup.py install
    python setup.py install --user 
    cd $HERE

    echo "installing flux finished\n"
    echo "done" >> log.txt
    echo "INSTALL APPLICATIONS DONE"
}
## icons
config_icons()
{
    echo "start config icons..." >> log.txt

    wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh

    echo "ICONS CONFIG DONE" >> log.txt
}
## powerline font
powerline_fonts()
{
    echo "start config powerline fonts" >> log.txt
    
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh 
    cd $HERE
    rm -rf fonts
}
while getopts 01234567 option
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
            echo "5";;
        6)
            echo "add ppa for your system"
            add_ppa
            echo "6";;
        7)
            echo "do all"
            add_ppa
            update_system
            install_apps
            config_font
            powerline_fonts
            config_vim
            config_zsh
            config_icons
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
            echo "-7  do all for your system, if your system is new one"
            echo "-----"
            echo "if you use zsh && vim, you should install powerline fonts at first"
            echo "if you want to install apps, you should add ppa at first"
            echo "bye";;
    esac
done
