#!/bin/bash
 
# Para mostrar los comandos que se van ejecutando (x) y parar en error(e)
set -ex

source .env

# Actualizamos la lista de repositorios
 apt update
# ACtualizamos los paquetes del sistema
# apt upgrade -y

#modificamos el parametro max_input_vars
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.1/apache2/php.ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.1/cli/php.ini

#habilitamos el modulo rewrite y reiniciamos apache
a2enmod rewrite 
systemctl restart apache2

# Eliminamos descargas previas
rm -rf /tmp/moodle-4.3.1
rm -rf /var/www/html/*
rm -rf /var/www/moodledata

mkdir /var/www/moodledata
chmod 0777 /var/www/moodledata

apt install zip -y

wget https://github.com/moodle/moodle/archive/refs/tags/v4.3.1.zip -P /tmp

unzip /tmp/v4.3.1.zip -d /tmp

chown -R root /tmp/moodle-4.3.1/*
chmod -R 0755 /tmp/moodle-4.3.1/*

mv /tmp/moodle-4.3.1/* /var/www/html



# Modificarmos los premisos de /var/www/html
chown -R www-data:www-data /var/www/html

sudo -u www-data php /var/www/html/admin/cli/install.php \
        --lang=$LANG \
        --wwwroot=$WWWROOT \
        --dataroot=$DATAROOT \
        --dbtype=$DBTYPE \
        --dbhost=$DBHOST \
        --dbname=$DBNAME \
        --dbuser=$DBUSER \
        --dbpass=$DBPASS \
        --fullname="$FULLNAME" \
        --shortname="$SHORTNAME" \
        --summary="$SUMMARY" \
        --adminpass="$ADMINPASS" \
        --adminemail=$MOODLE_ADMIN_EMAIL \
        --non-interactive \
        --agree-license