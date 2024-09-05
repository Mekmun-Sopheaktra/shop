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

# Node
echo "---------------------- ${B_WHITE}${GREEN}SP : Start install nodejs and npm${RESET} ----------------------"
echo "---------------------- ${B_WHITE}${GREEN}SP : Installing nodejs${RESET} ----------------------"
sudo apt install nodejs;
sudo apt install npm;

sudo apt install curl 
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

source /home/$USER/.bashrc

nvm install node
nvm install 18
# sudo npm install pm2@latest -g
echo "---------------------- ${B_WHITE}${GREEN}SP : Installed nodejs and npm${RESET} --------s--------------"

exit