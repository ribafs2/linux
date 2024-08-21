#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
apt-get install dialog;
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Instalação de pacotes no Ubuntu Server 14.04 LTS - 64' \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                1 'Atualizar repositórios' \
                2 'Instalar Servidor Web e cia' \
                3 'Efetuar o Upgrade da distribuição' \
                0 'Sair' )
    case $servico in
      1) apt-get update;;
      2) clear;
echo "Instalar pacotes básicos. Tecle Enter para instalar!";
apt-get install aptitude unzip ntp ntpdate git kolourpaint4 gnome-search-tool;

clear;
echo "Instalar Apache e módulos. Tecle Enter para instalar!";
apt-get install apache2 libapache2-mod-php5;
a2enmod rewrite;

clear;
# Instalar SGBDs somente para testes locais. Visto que o servidor é outro: 10.0.0.60
apt-get install postgresql postgresql-contrib;
apt-get install mysql-server;
apt-get install sqlite3;

mkdir /usr/share/adminer
wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
echo "Alias /adminer.php /usr/share/adminer/adminer.php" | sudo tee /etc/apache2/conf-available/adminer.conf
a2enconf adminer.conf

clear;
echo "Instalar PHP 5 e extensões. Tecle Enter para instalar!";
apt-get install php5 mcrypt php5-mcrypt php5-gd php5-mysql php5-sqlite php5-pgsql php5-ldap;
apt-get install php5-mcrypt php-pear php5-xsl curl php5-curl phpunit php5-xdebug php5-intl;
apt-get install php-gettext php5-fpm php-auth;

clear;
echo "Instalar suporte a cache no PHP. Tecle Enter para instalar!";
# Cache de php
apt-get install php5-apcu;
apt-get install memcached php5-memcache;

clear;
echo "Configurar php (display_errors = On)
Aperte ENTER para abrir o php.ini";

nano /etc/php5/apache2/php.ini;
service apache2 restart;

echo "Configurar .htaccess no Apache 2.4 trocando None por All
No apache2.conf:

ServerName localhost

<Directory />
    Options Indexes FollowSymLinks Includes ExecCGI
    AllowOverride All
    Order deny,allow
    Allow from all
</Directory>

Atalho para Desligar e reiniciar com CTRL+ALT+DEL
gnome-session-quit --power-off

Aperte ENTER para configurar.
";
read n;

nano /etc/apache2/apache2.conf;

service apache2 restart;

addgroup webdevel;
adduser www-data webdevel;
adduser ribafs webdevel;

echo "Setar permissões para /var/www/html/\$1

clear;
echo \"Aguarde enquanto configuro as permissões do /var/www/html/\$1\";
echo \"\";
chown -R www-data:webdevel /var/www/html/\$1;
chmod -R g+s /var/www/html/\$1;
#chmod -R u+s /var/www/html/\$1;
#chgrp -R webdevel /var/www/html/$1
find /var/www/html/\$1 -type d -exec chmod 2775 {} \;
find /var/www/html/\$1 -type f -exec chmod 2664 {} \;
echo \"\";
echo \"Concluído!\";

Selecionar o código acima
Tecle Enter e cole com Shift+Insert.
";
read n;

nano /usr/local/bin/perms;
chmod +x /usr/local/bin/perms;;

	  3) clear;
echo "Efetuar update e upgrade do Sistema. Algumas vezes é necessário reboot.
Geralmente após a instalação.
Tecle Enter.";

apt-get update;
apt-get upgrade;;
      0) clear;exit;;
   esac
done
