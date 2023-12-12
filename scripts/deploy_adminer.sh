#!/bin/bash

set -ex

apt install adminer -y

sudo systemctl enable apache2

sudo a2enconf adminer

sudo systemctl reload apache2