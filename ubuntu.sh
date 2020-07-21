#!/bin/bash
cd /etc/apt/sources.list.d/
sed -i '4s/^/# /' official-package-repositories.list
cd
if [ ! -e /etc/apt/sources.list.d/virtualbox.list ]
then
    echo "deb http://download.virtualbox.org/virtualbox/debian eoan contrib" >> /etc/apt/sources.list.d/virtualbox.list
fi
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
apt-get update && apt-get install htop samba cups cups-pdf zip rar remmina remmina-plugin-* openssh-server apt-transport-https hplip hplip-gui virtualbox-6.1 -y
dpkg -s apt-transport-https > /dev/null || bash -c "apt-get update; apt-get install apt-transport-https -y"
if [ ! -e /etc/apt/sources.list.d/skypeforlinux.list ]
then
    echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skypeforlinux.list
fi
apt-get update && apt-get install skypeforlinux -y --force-yes
mv ~/.local/share/keyrings/login.keyring .local/share/keyrings/login.keyring.bkp
wget https://download.virtualbox.org/virtualbox/6.1.12/Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack
apt install smbclient -y
grep -rIl 'WORKGROUP' /etc/samba/smb.conf | xargs sed -i 's/WORKGROUP/CARLU/g'
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list && apt update && apt install anydesk
if [ ! -e /usr/share/applications/totvs.desktop ]
then
    wget --no-check-certificate -r 'https://docs.google.com/uc?export=download&id=186We3f_PYjf-zqVyhr5V5kMCaApL6uh_' -O smartclient.zip
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
exit
