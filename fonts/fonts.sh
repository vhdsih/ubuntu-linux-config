#!/bin/bash

sudo cp -r ../resource/Monaco /usr/share/fonts
echo "" > ../log/fonts.txt
if [ $? == 0 ]; then
    echo "copy fonts successfully!" >> ../log/font.txt
else
    echo "false when cpoy the fonts" >> ../log/font.txt
fi
cd /usr/share/fonts/Monaco
sudo chmod 755 *
sudo mkfontscale
sudo mkfontdir;
sudo fc-cache -fv


