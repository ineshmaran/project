#!/bin/bash
sudo echo -e "192.168.100.11 puppetagent1.puppet.com\n192.168.100.12 puppetagent2.puppet.com" | sudo tee -a /etc/hosts
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-port=8140/tcp
sudo yum -y install ntp
sudo timedatectl set-timezone Asia/Kolkata
sudo systemctl start ntpd
sudo firewall-cmd --add-service=ntp --permanent
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum -y install puppetserver
sudo touch /etc/puppetlabs/puppet/autosign.conf
sudo echo "*" | sudo tee -a /etc/puppetlabs/puppet/autosign.conf
sudo firewall-cmd --reload
sudo echo -e "[main]\ncertname=puppetmaster.puppet.com" >> /etc/puppetlabs/puppet/puppet.conf
sudo sed -i 's/JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"/JAVA_ARGS="-Xms256m -Xmx256m -XX:MaxPermSize=256m"/g' /etc/sysconfig/puppetserver
sudo puppet master --no-daemonize --verbose
sudo systemctl enable puppetserver
sudo systemctl start puppetserver
