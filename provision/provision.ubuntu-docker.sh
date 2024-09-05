#! /usr/bin/env bash
# Variables
USER=$1
PASSWD=$2
GROUP=$3

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

echo "---------------------- ${B_WHITE}${GREEN}SP : Installing Docker ${RESET} ----------------------"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce-cli -y
sudo apt install docker-ce -y
sudo systemctl start docker
sudo docker version
echo "______________________ ${B_WHITE}${BLUE}SP : Installed Docker${RESET} ______________________"
exit