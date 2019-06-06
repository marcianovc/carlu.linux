#!/bin/bash
$user = `whoami`
su
apt update && apt install sudo -y && adduser $user sudo
echo "Instalando Remmina"
echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee --append /etc/apt/sources.list.d/stretch-backports.list >> /dev/null
apt update
apt install -t stretch-backports remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice -y
wget https://go.skype.com/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
apt install cups-pdf zip hplip* -y
rm skypeforlinux-64.deb
su $user
cd
wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=1wgiUbBvRV8VwNmxjXRXVAo8zSwPvNFG_' -O smartclientLinux.zip
unzip smartclientLinux.zip && rm smartclientLinux.zip && cd smartclientLinux && rm totvs.desktop
echo "[Desktop Entry]" >> totvs.desktop
echo "Version=1.0" >> totvs.desktop
echo "Type=Application" >> totvs.desktop
echo "Terminal=false" >> totvs.desktop
echo "Icon=`pwd`/Protheus11.png" >> totvs.desktop
echo "Icon[pt_BR]=`pwd`/Protheus11.png" >> totvs.desktop
echo "Exec=`pwd`/smartclient -m" >> totvs.desktop
echo "Name=TOTVS" >> totvs.desktop
chmod +x totvs.desktop
sudo cp totvs.desktop /usr/share/applications/
sudo dpkg --add-architecture i386 && apt-get update
sudo apt-get install gcc-multilib lib32z1 lib32ncurses5 libglib2.0-0:i386 libsm6:i386 libxrender1:i386 libxext6:i386 -y
