#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
apt-get install dialog;
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de pacotes no Ubuntu Server 16.04 LTS - 64' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                1 'Atualizar repositórios' \
                2 'Instalar LAMP e outros' \
                0 'Sair' )
    case $servico in
      1) apt-get update;;
      2) clear;
# "Instalar pacotes básicos. Tecle Enter para instalar!";
apt-get -y install apache2 libapache2-mod-php7.0 aptitude git mc;

# "Instalar Apache e módulos. Tecle Enter para instalar!";

a2dismod php7.0;
a2enmod rewrite;

# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
apt-get -y install mysql-server;

# "Instalar PHP 7 e extensões. Tecle Enter para instalar!";
apt-get -y install php7.0-bcmath php7.0 mcrypt php7.0-gd php7.0-mysql;
apt-get -y install php7.0-mcrypt php-pear php7.0-xml  php7.0-xsl curl php7.0-curl phpunit php-xdebug php7.0-intl composer;
apt-get -y install php7.0-zip php7.0-mbstring php-gettext php-mbstring php7.0-fpm;
phpenmod mbstring;

# "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
apt-get -y install php-apcu;

wget http://ftp.ussg.iu.edu/linux/ubuntu/pool/main/m/memcached/memcached_1.4.25-2ubuntu1_amd64.deb;
dpkg -i memcached_1.4.25-2ubuntu1_amd64.deb;
apt-get -y install php-memcache;

echo "Configurar php (display_errors = On)
date.timezone = America/Fortaleza
Aperte ENTER para abrir o php.ini";

nano /etc/php/7.0/apache2/php.ini;
service apache2 restart;

clear;

echo "Configurar .htaccess no Apache 2.4 trocando None por All
<Directory />
    Options Indexes FollowSymLinks Includes ExecCGI
    AllowOverride All
    Order deny,allow
    Allow from all
</Directory>

ServerName localhost

Adicionar ao final:
<FilesMatch \.php$>
SetHandler application/x-httpd-php
</FilesMatch>";
echo "";
echo "";
echo "Qualuer tecla para continuar";

read n;
nano /etc/apache2/apache2.conf;

a2dismod mpm_event;
a2enmod mpm_prefork;
a2enmod php7.0;

apt-get -y install ttf-mscorefonts-installer;
apt-get -y install rar unrar zip unzip p7zip-full ubuntu-restricted-extras kolourpaint4 gnome-search-tool shutter;

apt-get -y update;
apt-get -y upgrade;;
      0) clear;exit;;
   esac
done
