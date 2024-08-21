#!/bin/bash
#
# Criado/adaptado por Ribamar FS - http://ribafs.org
#
# dialog is a utility installed by default on all major Linux distributions.
# But it is good to check availability of dialog utility on your Linux box.
if [ -e /usr/bin/dialog ]; then
	echo '';
else
	clear
	echo "A dialog não está instalada, instalando!" && apt-get install dialog;
fi;
#
show_cal(){
	dialog --inputbox 'Digite uma data no formato dd mm aaaa:' 0 0  2>/tmp/nome.txt;
	data=$( cat /tmp/nome.txt );

    dialog --backtitle "Calendário" --title "Hoje" \
    --calendar "Dia da semana de uma data" 0 0 $data;
}
#
while :
 do
    clear
servico=$(dialog --stdout --backtitle 'Ubuntu - Pos Install (Apache 2.2 ou 2.4)'   \
                --menu 'Selecione a opção com a seta ou o número e tecle Enter\n' 0 0 0 \
                1 'Atualizar repositórios' \
                2 'Instalar o SystemBack' \
                3 'Instalar Servidor Web e MySQL' \
                4 'Sugestões para hostname' \
                5 'Instalar compactadores, Java e outros pacotes' \
                6 'Efetuar o Upgrade da distribuição' \
                7 'Dicas Extras' \
				8 'Calendário' \
                0 'Sair' )
    case $servico in
      1) sudo apt-get update;;
      2) echo "Logo que termine de instalar/configurar, use o SystemBack para fazer\n
um backup completo (ponto de operação), para eventual recovery\n
Aperte ENTER para continuar";
read n
sudo apt-add-repository ppa:nemh/systemback;
sudo apt-get update;
sudo apt-get -y install systemback;;
      3) clear;
echo "Instalar Servidor Web e MySQL

Quando perguntado sobre o servidor web para o phpmyadmin selecione
apache2

Quando perguntado sobre sobre a configuração de base de dados para phpmyadmin responda
Não
Aperte ENTER para instalar o Servidor Web e o MySQL";
read n;

sudo apt-get -y install mysql-server apache2 php5 libapache2-mod-php5 php5-gd php5-mysql php5-pgsql php5-mcrypt php-pear php5-ming php5-xsl php5-curl phpmyadmin phpunit php5-xdebug php5-intl;
sudo a2enmod rewrite;

echo "Aperte ENTER para continuar";
read n;

clear
echo "Configurar php (display_errors = On)
Aperte ENTER para abrir o php.ini";
read n;
sudo nano /etc/php5/apache2/php.ini;
sudo service apache2 restart;

echo "
Configurar o phpmyadmin para aceitar senha em branco
Descomentar as duas linhas como a abaixo: Copie e cole o conteúdo abaixo no arquivo

// $cfg['Servers'][$i]['AllowNoPassword'] = TRUE

Aperte ENTER para configurar o phpmyadmin";
read n;
sudo nano /etc/phpmyadmin/config.inc.php;

echo "
Mudando diretório web no Apache 2.4. No apache 2.2 o arquivo é apenas default
ao invés de 000-default.conf mude para 'default'

<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /backup/www
Aperte ENTER para mudar o diretório web no Apache2.4";
echo "Digite a versão do seu apache: 22 ou 24";

sudo nano /etc/apache2/sites-available/000-default.conf

echo "Aperte ENTER para configurar .htaccess no Apache 2.4";
echo "Para permitir .htaccess no Apache 2.4. No 2.2 é direto no default acima

Exemplo:
Mudar assim:
...
<Directory />
        Options FollowSymLinks
        AllowOverride All
        Require all denied
</Directory>

<Directory /usr/share>
        AllowOverride None
        Require all granted
</Directory>

<Directory /backup/www/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
...
";
sudo nano /etc/apache2/apache2.conf;;

4) dialog --title "Sugestões para Configurar hostname e hosts \n
--msgbox \n
hostname = desktop\n\n
sudo nano /etc/hosts\n
Deixe somente estas duas linhas (adaptadas para seu servidor):\n
127.0.0.1	notebook.local	localhost.localdomain	notebook	localhost\n
Aperte ENTER para reiniciar o Apache" 20 100;

sudo service apache2 restart;;

5) sudo apt-get -y install rar unrar zip unzip p7zip-full p7zip-rar arj aptitude ubuntu-restricted-extras build-essential k3b wine kolourpaint4 gnome-search-tool gedit-plugins;
sudo apt-get -y purge openjdk*
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer
echo "
Aperte ENTER para continuar";
read n;
clear;
echo "
Aperte ENTER para adicionar os repositórios do Remastersys";
read n;;
	  6) clear;
sudo apt-get update;
sudo apt-get upgrade;;
	  7) dialog --title "Dicas Extras" \
		--msgbox "\n
Configurar Nautilus (clique único)\n
\n
Adicionar teclas de atalho customizadas para:\n
firefox, gedit, gnome-terminal, nautilus /backup/transp, libreoffice -writer
\n
Configurar Firefox\n
página inicial\n
download\n
\n
Configurar Google\n
100/página\n
Abrir noutra\n
\n
Ativar o Firefox Sync\n
\n
Configurar LibreOffice Writer:\n
Caminho\n
Fonte default como Arial\n
Aspas e aspas duplas\n
\n
Configurar terminal:\n
Colunas - 135\n
Linhas - 38\n
\n
Gedit:\n
Exibir número de linhas\n
Não salvar backup\n
Tabulação com 4\n
\n" 60 100;

clear
echo "========= MAIS ALGUMAS DICAS ==========

Para facilitar copie daqui (basta selecionar), 
abra outro terminal e 
cole (com SHIFT+INSERT).

Ativar o Backspace no Ubuntu, necessário somente nas versões 13.xx
Execute como sudo:

cd
echo '(gtk_accel_path \"<Actions>/ShellActions/Up\" \"BackSpace\")' >> .config/nautilus/accels

Atalho para Desligar e reiniciar com CTRL+ALT+DEL
gnome-session-quit --power-off

Desabilitar relatório de erros:
sudo sed -i 's/enabled=1/enabled=0/' /etc/default/apport
sudo service apport stop

Segurar o brilho (Notebook):
sudo nano /etc/rc.local
Antes de exit 0:
echo 4 > /sys/class/backlight/acpi_video0/brightness

Restaurar Firefox em caso de problema:
about:support
	Restaurar o Firefox

Finalize e então reinicie o computador
Aperte qualquer tecla para voltar ao menu";
read n;;
	  8) show_cal;;
      0) clear;exit;;
   esac
done

