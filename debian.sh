#!/bin/bash
if [ ! -e /etc/apt/sources.list.d/stretch-backports.list ]
then
    echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee --append /etc/apt/sources.list.d/stretch-backports.list >> /dev/null
fi
apt update
apt install -t stretch-backports remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice cups-pdf zip hplip* -y
wget https://go.skype.com/skypeforlinux-64.deb /home/$user/
dpkg -i /home/$user/skypeforlinux-64.deb
cd /home/$user/
wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=1wgiUbBvRV8VwNmxjXRXVAo8zSwPvNFG_' -O smartclientLinux.zip
unzip smartclientLinux.zip && rm smartclientLinux.zip && chown $user:$user smartclientLinux/ && chmod -R 777 smartclientLinux/ && cd smartclientLinux && rm totvs.desktop
echo "[Desktop Entry]" >> totvs.desktop
echo "Version=1.0" >> totvs.desktop
echo "Type=Application" >> totvs.desktop
echo "Terminal=false" >> totvs.desktop
echo "Icon=`pwd`/Protheus11.png" >> totvs.desktop
echo "Icon[pt_BR]=`pwd`/Protheus11.png" >> totvs.desktop
echo "Exec=`pwd`/smartclient -m" >> totvs.desktop
echo "Name=TOTVS" >> totvs.desktop
chmod +x totvs.desktop && chown $user:$user totvs.desktop && cp totvs.desktop /usr/share/applications/
dpkg --add-architecture i386 && apt-get update
apt-get install gcc-multilib lib32z1 lib32ncurses5 libglib2.0-0:i386 libsm6:i386 libxrender1:i386 libxext6:i386 -y
