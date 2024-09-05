#! /usr/bin/env bash
# Variables
USER=$1
PASSWD=$2
GROUP=$3
EMAIL=$4

BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
B_BLACK=`tput setaf 0`
B_RED=`tput setaf 1`
B_GREEN=`tput setaf 2`
B_YELLOW=`tput setaf 3`
B_BLUE=`tput setaf 4`
B_MAGENTA=`tput setaf 5`
B_CYAN=`tput setaf 6`
B_WHITE=`tput setaf 7`
RESET=`tput sgr0`

echo "______________________ ${B_WHITE}${BLUE}SP : Start Provision${RESET} ______________________"

echo "---------------------- ${B_WHITE}${GREEN}SP : Start Update and Upgrade lib${RESET} ----------------------"
sudo apt-get update
sudo apt-get upgrade -y
echo "---------------------- ${B_WHITE}${GREEN}SP : Finish Update and Upgrade lib${RESET} ----------------------"

# Nginx
echo "---------------------- ${B_WHITE}${GREEN}SP : Installing Nginx${RESET} ----------------------"
sudo apt-get install -y nginx
sudo sed -i.bak "s/^user $USER;/#user $USER;/g" /etc/nginx/nginx.conf
sudo sed -i "/^#user $USER;/a user $USER;" /etc/nginx/nginx.conf
sudo service nginx restart
echo "---------------------- ${B_WHITE}${GREEN}SP : Installed Nginx${RESET} ----------------------"
echo "---------------------- ${B_WHITE}${GREEN}SP : Configured Nginx User from $GROUP to vagrant${RESET} ----------------------"

VirtualHostFiles=`ls /etc/nginx/conf.d/*.conf`
sudo su
for VirtualHostFile in $VirtualHostFiles
    do
    host="$(echo "$VirtualHostFile" | sed -e 's/\/etc\/nginx\/conf.d\/\(.*\)\.conf/\1/')"
	cat > $VirtualHostFile << EOF
server {
	listen 80;
	server_name $host www.$host;

    access_log /var/log/nginx/$host-access.log;
    error_log /var/log/nginx/$host-error.log;

	root /var/www/vhosts/;
	index index.php index.html;
	
    include snippets/php-fpm.conf;
}
EOF
    done

cat > /etc/nginx/snippets/php8.2-fpm.conf << EOF
location / {
	try_files $uri $uri/ @php8.2-fpm;
}

location /index.php {
	try_files /not_exists @php8.2-fpm;
}

location @php8.2-fpm {
	fastcgi_pass php8.2-fpm;
	fastcgi_keep_conn on;
	fastcgi_param SCRIPT_FILENAME $document_root/index.php;
	fastcgi_param PATH_INFO $fastcgi_script_name;
	fastcgi_read_timeout 3600;
	include fastcgi_params;
}

location ~* \.(eot|ttf|otf|woff|woff2)$ {
	expires 1h;
	add_header Access-Control-Allow-Origin "*";
}
EOF

cat > /etc/nginx/conf.d/upstream.conf << EOF
upstream php8.2-fpm {
    server unix:/run/php/php8.2-fpm.sock;

    keepalive 10;
}
EOF

# PHP
echo "---------------------- ${B_WHITE}${GREEN}SP : Installing PHP${RESET} ----------------------"
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update --fix-missing
sudo apt remove php php-*
sudo apt-get install -y php8.2-fpm php8.2-mbstring php8.2-curl php8.2-cli php8.2-intl php8.2-xml php8.2-zip php8.2-gd
# sudo apt-get install -y php8.2-fpm php8.2-mysql php8.2-mbstring php8.2-curl php8.2-cli php8.2-intl php8.2-xml php8.2-zip php8.2-gd
echo "---------------------- ${B_WHITE}${GREEN}SP : Installed PHP${RESET} ----------------------"

# Configure PHP-Fpm
echo "---------------------- ${B_WHITE}${GREEN}SP : Configure PHP fpm User from $GROUP to $USER ${RESET} ----------------------"

sudo sed -i.bak "s/^user = $USER/;user = $USER/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "s/^group = $GROUP/;group = $GROUP/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "/^;group = $GROUP.*/a group = $GROUP" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "/^;group = $GROUP.*/a user = $USER" /etc/php/8.2/fpm/pool.d/www.conf

sudo sed -i "s/^listen.owner = $GROUP/;listen.owner = $USER/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "s/^listen.group = $GROUP/;listen.group = $GROUP/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "/^;listen.group = $GROUP.*/a listen.group = $GROUP" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "/^;listen.group = $GROUP.*/a listen.owner = $GROUP" /etc/php/8.2/fpm/pool.d/www.conf

sudo sed -i "s/^listen = /run/php/php8.2-fpm.sock" /etc/php/8.2/fpm/pool.d/www.conf

sudo sed -i "s/^pm.max_children = 5/;pm.max_children = 5/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "s/^pm.start_servers = 2/;pm.start_servers = 2/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "s/^pm.min_spare_servers = 1/;pm.min_spare_servers = 1/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i "s/^pm.max_spare_servers = 3/;pm.max_spare_servers = 3/g" /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i '/^;pm.max_children = 5.*/a pm.max_children = 24' /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i '/^;pm.start_servers = 2.*/a pm.start_servers = 8' /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i '/^;pm.min_spare_servers = 1.*/a pm.min_spare_servers = 4' /etc/php/8.2/fpm/pool.d/www.conf
sudo sed -i '/^;pm.max_spare_servers = 3.*/a pm.max_spare_servers = 12' /etc/php/8.2/fpm/pool.d/www.conf

sudo service php8.2-fpm restart
echo "---------------------- ${B_WHITE}${GREEN}SP : Restarted PHP fpm${RESET} ----------------------"

echo "---------------------- ${B_WHITE}${GREEN}SP : Installing Composer ${RESET} ----------------------"
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
echo "---------------------- ${B_WHITE}${GREEN}SP : Installed Composer ${RESET} ----------------------"

exit