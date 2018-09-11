# Defining class.

class lamp {

# execute 'yum update'
exec { 'yum-update':
  path => '/bin',                 # exec resource named 'yum-update'
  command => 'yum update -y',  # command this resource will run
}

# install apache package
package { 'httpd':
  require => Exec['yum-update'],        # require 'apt-update' before installing
  ensure => installed,
}

# ensure apache service is running
service { 'httpd':
  ensure => running,
}

# Install MySQL packages installed
package { 'MySQL-server-community':
  provider => rpm,
  ensure => installed,
  source => 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm',
}

# install mysql-server package
package { 'mysql-server':
  require => Exec['yum-update'],        # require 'yum update' before installing
  ensure => installed,
}

# ensure mysql service is running
service { 'mysqld':
  ensure => running,
}

# install php5 package
package { 'php':
  require => Exec['yum-update'],        # require 'yum update' before installing
  ensure => installed,
}

# ensure info.php file exists
file { '/var/www/html/info.php':
  ensure => file,
  owner => apache,
  group => apache,
  content => '<?php  phpinfo(); ?>',    # phpinfo code
  require => Package['httpd'],        # require 'httpd' package before creating
}

}
