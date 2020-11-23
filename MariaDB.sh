#!/bin/bash

sudo yum install mariadb-server mariadb -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
printf "\n n\n y\n y\n y\n y\n" | mysql_secure_installation
sudo mysql -e "CREATE DATABASE wordpress"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO wpuser@'%' IDENTIFIED BY 'dbpass'"
sudo systemctl restart mariadb
sudo setenforce 0