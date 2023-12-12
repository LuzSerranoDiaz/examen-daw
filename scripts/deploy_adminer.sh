#!/bin/bash

set -ex

apt install adminer -y

wget https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1-mysql.php -P /var/www/html

sudo systemctl enable apache2

sudo a2enconf adminer

sudo systemctl reload apache2