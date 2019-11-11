#!/bin/bash
sed -i '$d' /var/lib/jenkins/.ssh/known_hosts
sed -i '$d' /etc/hosts
