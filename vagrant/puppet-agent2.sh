#!/bin/bash
sudo echo -e "192.168.100.12 puppetagent2.puppet.com\n192.168.100.10 puppetmaster.puppet.com" | sudo tee -a /etc/hosts
sudo timedatectl set-timezone Asia/Kolkata
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum -y install puppet-agent
sudo mv /opt/puppetlabs/bin/puppet /usr/bin/
sudo echo -e "[agent]\nserver=puppetmaster.puppet.com" >> /etc/puppetlabs/puppet/puppet.conf
sudo puppet agent -tv
sudo systemctl start puppet
sudo systemctl enable puppet
