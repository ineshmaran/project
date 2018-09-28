#!/bin/bash
CONFIG_FILE_LOCATION=/etc/config_file.txt
echo -ne "\nEnter username: "
read username
echo -ne "\nEnter password: "
read -s input1
echo -ne "\n\nRe-enter password: "
read -s input2
if [[ $input1 = $input2 ]]; then
  export PASSWORD=$input1
  sed -i "s/Username: .*/Username: $username/g" $CONFIG_FILE_LOCATION
  sed -i "s/Password: .*/Password: $PASSWORD/g" $CONFIG_FILE_LOCATION
  echo -e "\n\n"
  #####
  #Run DNS update command#
  yum install httpd -y
  systemctl start httpd
  systemctl status httpd
  #####
  if [ $? -eq 0 ]; then
    unset PASSWORD
    echo -e "\n\n"
    sed -i "s/Password: .*/Password: $PASSWORD/g" $CONFIG_FILE_LOCATION
  else
    echo -e "\n\nDNS update command failed\n\n"
    exit 1
  fi
else
  echo -e '\n\n\nPasswords do not match!!\n\n'
  exit 1
fi
