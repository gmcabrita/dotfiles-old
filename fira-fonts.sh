#!/bin/sh
set -e

curl -Lo master.zip https://github.com/carrois/Fira/archive/master.zip
unzip master.zip
sudo mkdir -p /usr/share/fonts/opentype/fira_code
sudo mkdir -p /usr/share/fonts/opentype/fira_mono
sudo mkdir -p /usr/share/fonts/opentype/fira_sans
sudo cp Fira-master/Fira_Code_3_2/Fonts/FiraCode_OTF_32/* /usr/share/fonts/opentype/fira_code
sudo cp Fira-master/Fira_Mono_3_2/Fonts/FiraMono_OTF_32/* /usr/share/fonts/opentype/fira_mono
sudo cp Fira-master/Fira_Sans_4_2/Fonts/FiraSans_OTF_4203/Normal/Roman/* /usr/share/fonts/opentype/fira_sans
sudo cp Fira-master/Fira_Sans_4_2/Fonts/FiraSans_OTF_4203/Normal/Italic/* /usr/share/fonts/opentype/fira_sans
