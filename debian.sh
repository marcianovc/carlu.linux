#!/bin/bash
user=`egrep '1[0-9]{3}' /etc/passwd | cut -d \: -f1`
cd /home/$user/
if [ ! -e /etc/apt/sources.list.d/buster-backports.list ]
then
    echo 'deb http://ftp.debian.org/debian buster-backports main' | sudo tee --append /etc/apt/sources.list.d/buster-backports.list >> /dev/null
fi
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
apt update
apt install -t buster-backports remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice cups-pdf zip hplip* apt-transport-https aptitude htop gzip net-tools -y
apt install virtualbox-6.1 -y
if [ ! -e /usr/share/applications/skypeforlinux.desktop ]
then
    wget https://go.skype.com/skypeforlinux-64.deb && dpkg -i skypeforlinux-64.deb && rm -rf skypeforlinux-64.deb
fi
if [ ! -e /usr/share/applications/totvs.desktop ]
then
    wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=1B6aasy_Xyc_-U_n2xWfTy0CzsLryXw20' -O smartclient.zip
    unzip smartclient.zip && rm -rf smartclient.zip
    chown -R $user:$user smartclient/ && chmod -R 777 smartclient/ && cd smartclient && rm -rf totvs.desktop
    echo "[Desktop Entry]" >> totvs.desktop
    echo "Version=1.0" >> totvs.desktop
    echo "Type=Application" >> totvs.desktop
    echo "Terminal=false" >> totvs.desktop
    echo "Icon=`pwd`/Protheus11.png" >> totvs.desktop
    echo "Icon[pt_BR]=`pwd`/Protheus11.png" >> totvs.desktop
    echo "Exec=`pwd`/smartclient.sh" >> totvs.desktop
    echo "Name=TOTVS" >> totvs.desktop
    grep -rl "marciano" smartclient.sh | xargs sed -i "s/marciano/$user/g"
    chmod +x totvs.desktop && chmod 777 totvs.desktop && mv totvs.desktop /usr/share/applications/
fi
dpkg --add-architecture i386 && apt update
aptitude install gcc-multilib lib32z1 lib32ncurses5-dev libglib2.0-0:i386 libsm6:i386 libxrender1:i386 libxext6:i386 -y
apt install gcc-multilib lib32z1 lib32ncurses5-dev libglib2.0-0:i386 libsm6:i386 libxrender1:i386 libxext6:i386 -y
apt --fix-broken install -y
if [ ! -e /usr/share/applications/com.teamviewer.TeamViewer.desktop ]
then
    echo -e "deb http://linux.teamviewer.com/deb stable main\ndeb http://linux.teamviewer.com/deb preview main" > /etc/apt/sources.list.d/teamviewer.list
    wget -O - https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | apt-key add -
    apt update && apt install teamviewer -y
fi
git clone https://github.com/eduardoalthaus/hddtest && cd hddtest && chmod +x run.sh && ./run.sh && apt install smbclient -y
grep -rIl 'WORKGROUP' /etc/samba/smb.conf | xargs sed -i 's/WORKGROUP/CARLU/g'
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list && apt update && apt install anydesk
exit
