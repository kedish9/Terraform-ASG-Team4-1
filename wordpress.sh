#!/bin/bash

sudo yum install httpd wget unzip vim -y
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager       --enable  remi-php74
sudo yum install php   php-mysql mysql -y
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip 
sudo rsync -r wordpress/  /var/www/html/
sudo chown -R apache:apache /var/www/html/
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl restart httpd
sudo setenforce 0

