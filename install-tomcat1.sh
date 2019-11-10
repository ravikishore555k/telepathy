#!/bin/bash
##sudo apt-get upgrade -y
#sudo apt install software-properties-common apt-transport-https -y
#sudo add-apt-repository ppa:openjdk-r/ppa -y
#sudo apt install openjdk-8-jdk -y
sudo ufw allow from any to any port 22 proto tcp
sudo chown ubuntu:ubuntu /opt/
sudo su
echo PermitRootLogin yes >> /etc/ssh/sshd_config
service ssh restart




