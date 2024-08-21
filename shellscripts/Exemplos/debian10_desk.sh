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
# "Instalar pacotes básicos. Tecle Enter para instalar!";
apt install -y apache2 libapache2-mod-php7.3 aptitude git mc;

# "Instalar Apache e módulos. Tecle Enter para instalar!";

a2enmod rewrite;
systemctl restart apache2;

# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
apt install -y postgresql mariadb-server;

# "Instalar PHP 7 e extensões. Tecle Enter para instalar!";
apt install -y php7.3-bcmath php7.3 mcrypt php7.3-gd php7.3-mysql php7.3-sqlite3 php7.3-pgsql php7.3-mongodb;
apt install -y php-pear php7.3-xml  php7.3-xsl curl php7.3-curl phpunit php-xdebug php7.3-intl composer;
apt install -y php7.3-zip php7.3-mbstring php-gettext php-mbstring;
apt install -y php-curl php7.3-gd;
#phpenmod mbstring

# "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
# Cache de php
apt install -y php-apcu;

wget http://ftp.ussg.iu.edu/linux/debian/pool/main/m/memcached/memcached_1.5.6-1.1_amd64.deb;
dpkg -i memcached_1.5.6-1.1_amd64.deb;
apt install -y php-memcache;

wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
dpkg -i vscode.deb

/etc/init.d/apache2 restart;

apt install -y zip unzip p7zip-full k3b kolourpaint4 openjdk-11-jdk;

# Autocorreção no Libreoffice
apt install -y libreoffice-l10n-pt-br vokoscreen searchmonkey;

# "Efetuar update e upgrade do Sistema. Algumas vezes é necessário reboot";
apt -y update;
apt -y upgrade;;
      0) clear;exit;;
   esac
done
