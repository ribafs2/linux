	#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
apt install dialog;
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de outros pacotes para Debian 10' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                2 'Instalar LAMP e outros' \
                0 'Sair' )
    case $servico in
      2) clear;
apt update;
# "Instalar pacotes básicos. Tecle Enter para instalar!";
apt install -y aptitude mc;

# Instalar o firewall ufw. Habilite após a instalação: sudo ufw enable
apt install -y ufw;

# outros
apt install -y zip unzip p7zip-full k3b kolourpaint4 vlc filezilla ssh samba smbclient wireshark;

# Instalar leitor de .chm (help do windows, ex.: manual do PHP):
apt-get install -y kchmviewer;

# Autocorreção no Libreoffice
apt install -y libreoffice-l10n-pt-br vokoscreen searchmonkey dia peek;
## peek - captura tela e exporta para gif e outros


#Debian 9, Ubuntu 14.04 and Mint 17
#If you get gnutls_handshake() errors after adding the Brave repository on Debian 9, you may need to uninstall old conflicting packages.

sudo apt install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-trusty.list

sudo apt update

sudo apt install brave-browser

# "Efetuar update e upgrade do Sistema. Algumas vezes é necessário reboot";
apt -y update;
apt -y upgrade;;
      0) clear;exit;;
   esac
done

