#!/bin/bash
sed -i '$d' /var/lib/jenkins/.ssh/known_hosts
exit
sudo sed -i '$d' /etc/hosts
