#!/bin/bash
 
# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
 apt update
# ACtualizamos los paquetes del sistema
# apt upgrade -y

# Instalamos el servidor APACHE
apt install apache2 -y

# Instalar php 
apt install php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php8.1-zip php-gd php-intl -y

# Copiamos archivo de configuracion de apache
cp ../conf/000-default.conf /etc/apache2/sites-available

#Reiniciamos servicio apache
systemctl restart apache2

# Cambiamos usuario y propietario de var/www/html
chown -R www-data:www-data /var/www/html
