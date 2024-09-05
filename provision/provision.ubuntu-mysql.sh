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

# MySql - MariaDB and PhpMyAdmin
echo "---------------------- ${B_WHITE}${GREEN}SP : Start install and configure MySql - MariaDB and PhpMyAdmin${RESET} ----------------------"
echo "---------------------- ${B_WHITE}${GREEN}SP : Install software-properties-common${RESET} ----------------------"
sudo apt-get -y install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
sudo apt-get update --fix-missing
echo "---------------------- ${B_WHITE}${GREEN}SP : Install mariadb-server mariadb-client${RESET} ----------------------"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWD"
sudo apt-get -y install mariadb-server mariadb-client
echo "---------------------- ${B_WHITE}${GREEN}SP : Install phpmyadmin${RESET} ----------------------"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
sudo apt-get -y install phpmyadmin
echo "---------------------- ${B_WHITE}${GREEN}SP : Configure MySql${RESET} ----------------------"
sudo sed -i.bak "s/^bind-address/#bind-address/g" /etc/mysql/my.cnf
sudo sed -i "s/^skip-external-locking/#skip-external-locking/g" /etc/mysql/my.cnf
echo "---------------------- ${B_WHITE}${GREEN}SP : Restart nginx and mysql service${RESET} ----------------------"
sudo service mysql restart
echo "---------------------- ${B_WHITE}${GREEN}SP : Finish install and configure MySql - MariaDB and PhpMyAdmin${RESET} ----------------------"

# Node
echo "---------------------- ${B_WHITE}${GREEN}SP : Start install nodejs and npm${RESET} ----------------------"
echo "---------------------- ${B_WHITE}${GREEN}SP : Installing nodejs${RESET} ----------------------"
sudo apt-get -y install nodejs
echo "---------------------- ${B_WHITE}${GREEN}SP : Installing npm${RESET} ----------------------"
sudo apt-get -y install npm
echo "---------------------- ${B_WHITE}${GREEN}SP : Finish install nodejs and npm${RESET} --------s--------------"

echo "---------------------- ${B_WHITE}${GREEN}SP : Progressing Grant PRIVILEGES and Creating User ($USER)${RESET} ----------------------"
sudo mysql --user=root --password=$PASSWD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASSWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sudo mysql --user=root --password=$PASSWD -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASSWD';"
sudo mysql --user=root --password=$PASSWD -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;"
sudo mysql --user=root --password=$PASSWD -e "FLUSH PRIVILEGES;"
echo "---------------------- ${B_WHITE}${GREEN}SP : Complete Grant PRIVILEGES and Creating User ($USER)${RESET} ----------------------"

echo "---------------------- ${B_WHITE}${GREEN}SP : Start configure PhpMyAdmin with Nginx${RESET} ----------------------"
sudo sed -i "/^.*# pass PHP scripts to FastCGI server*/i \\\n        include snippets/phpmyadmin.conf;\n" /etc/nginx/sites-available/default
sudo su
cat > /etc/nginx/snippets/phpmyadmin.conf <<"EOF"
location /phpmyadmin {
    root /usr/share/;
    index index.php index.html index.htm;
    location ~ ^/phpmyadmin/(.+\.php)$ {
        try_files $uri =404;
        root /usr/share/;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
    }

    location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
        root /usr/share/;
    }
}
EOF
echo "---------------------- ${B_WHITE}${GREEN}SP : Done configure PhpMyAdmin with Nginx${RESET} ----------------------"
exit