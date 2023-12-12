#!/bin/bash
 
# Para mostrar los comandos que se van ejecutando (x) y parar en error(e)
set -ex

source .env

# Actualizamos la lista de repositorios
 apt update
# ACtualizamos los paquetes del sistema
# apt upgrade -y


# Creamos la base de datos y el usuario para wordpress
mysql -u root <<< "DROP DATABASE IF EXISTS $DBNAME"
mysql -u root <<< "CREATE DATABASE $DBNAME"
mysql -u root <<< "DROP USER IF EXISTS $DBUSER@'%'"
mysql -u root <<< "CREATE USER $DBUSER@'%' IDENTIFIED BY '$DBPASS'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DBNAME.* TO $DBUSER@'%'"
