[![issues](https://img.shields.io/github/issues/eduardoalthaus/carlu.linux.svg)](https://github.com/eduardoalthaus/carlu.mint/issues)
[![forks](https://img.shields.io/github/forks/eduardoalthaus/carlu.linux.svg)](https://github.com/eduardoalthaus/carlu.mint/network/members)
[![stars](https://img.shields.io/github/stars/eduardoalthaus/carlu.linux.svg)](https://github.com/eduardoalthaus/carlu.linux/stargazers)
[![license](https://img.shields.io/github/license/eduardoalthaus/carlu.linux.svg)](https://github.com/eduardoalthaus/carlu.linux/blob/master/LICENSE)
# carlu.linux
Script to install some apps in GNU/Linux Debian and/or Mint/Ubuntu.  
  
# Install  
<code>
su

apt --fix-broken install -y && apt update && apt install sudo git -y && apt upgrade -y && git clone https://github.com/marcianovc/carlu.linux.git && chmod -R 777 carlu.linux/ && cd carlu.linux && chmod +x *.sh && ./updateuser.sh</code>
