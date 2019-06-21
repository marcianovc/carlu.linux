#!/bin/bash
user=`egrep '1[0-9]{3}' /etc/passwd | cut -d \: -f1`
cd /home/$user/
if [ ! -e /etc/apt/sources.list.d/stretch-backports.list ]
then
    echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee --append /etc/apt/sources.list.d/stretch-backports.list >> /dev/null
fi
apt update
apt install -t stretch-backports remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice cups-pdf zip hplip* apt-transport-https aptitude htop gzip net-tools -y
if [ ! -e /usr/share/applications/skypeforlinux.desktop ]
then
    wget https://go.skype.com/skypeforlinux-64.deb && dpkg -i skypeforlinux-64.deb && rm -rf skypeforlinux-64.deb
fi
if [ ! -e /usr/share/applications/totvs.desktop ]
then
    wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=1wgiUbBvRV8VwNmxjXRXVAo8zSwPvNFG_' -O smartclientLinux.zip
    unzip smartclientLinux.zip && rm -rf smartclientLinux.zip
    chown -R $user:$user smartclientLinux/ && chmod -R 777 smartclientLinux/ && cd smartclientLinux && rm -rf totvs.desktop
    echo "[Desktop Entry]" >> totvs.desktop
    echo "Version=1.0" >> totvs.desktop
    echo "Type=Application" >> totvs.desktop
    echo "Terminal=false" >> totvs.desktop
    echo "Icon=`pwd`/Protheus11.png" >> totvs.desktop
    echo "Icon[pt_BR]=`pwd`/Protheus11.png" >> totvs.desktop
    echo "Exec=`pwd`/smartclient -m" >> totvs.desktop
    echo "Name=TOTVS" >> totvs.desktop
    chmod +x totvs.desktop && chmod 777 totvs.desktop && mv totvs.desktop /usr/share/applications/
fi
dpkg --add-architecture i386 && apt update
aptitude install gcc-multilib lib32z1 lib32ncurses5 libglib2.0-0:i386 libsm6:i386 libxrender1:i386 libxext6:i386 -y
apt --fix-broken install -y
if [ ! -e /usr/share/applications/com.teamviewer.TeamViewer.desktop ]
then
    echo -e "deb http://linux.teamviewer.com/deb stable main\ndeb http://linux.teamviewer.com/deb preview main" > /etc/apt/sources.list.d/teamviewer.list
    wget -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | apt-key add -
    apt update && apt install teamviewer -y
fi
git clone https://github.com/eduardoalthaus/hddtest && cd hddtest && chmod +x run.sh && ./run.sh
exit
