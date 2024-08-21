#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
apt install dialog;
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de pacotes no Ubuntu Server 16.04 LTS - 64' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                2 'Instalar LAMP e outros' \
                0 'Sair' )
    case $servico in
      2) clear;
apt update;
# "Instalar pacotes básicos.";
apt install -y apache2 libapache2-mod-php7.3 git mcrypt curl phpunit composer;

# "Instalar Apache e módulos.";

a2enmod rewrite;
systemctl restart apache2;

# Instalar SGBDs
apt install -y mariadb-server;

# "Instalar PHP 7.3 e extensões.";
apt install -y php7.3-xml php7.3-xsl php7.3-curl php7.3-xdebug php7.3-intl php7.3 php7.3-bcmath php7.3-mysql;
apt install -y php7.3-zip php7.3-mbstring php7.3-gettext php7.3-gd php-curl php-pear;

# "Instalar suporte a cache no PHP.";
apt install -y php-apcu;

wget http://ftp.ussg.iu.edu/linux/debian/pool/main/m/memcached/memcached_1.5.6-1.1_amd64.deb;
dpkg -i memcached_1.5.6-1.1_amd64.deb;
apt install -y php-memcache php-memcached;

systemctl restart apache2;

# Instalar outros softwares
apt install -y ttf-mscorefonts-installer vokoscreen;
apt install -y rar unrar zip unzip p7zip-full kolourpaint;
#  shutter alarm-clock-applet
apt install -y fonts-crosextra-carlito fonts-crosextra-caladea;

# Autocorreção no Libreoffice
sudo apt install -y libreoffice-l10n-pt-br alarm-clock-applet dconf-editor searchmonkey;

# "Efetuar update e upgrade do Sistema. Geralmente é necessário reboot, nos casos em que o kernel seja atualizado";
apt -y update;
apt -y upgrade;;
      0) clear;exit;;
   esac
done
