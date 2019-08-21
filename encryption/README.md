This is used to use the password in env variables insteads of plain text.

1) When you use this script, it will prompt for username and password details. It holds the credentials and update in the config files. Here is the output of installing Apache server.

--

$ ./encrypt_password.sh

Enter username: inesh.maran@domain.com

Enter password:

Re-enter password:


Failed to set locale, defaulting to C
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.vbctv.in
 * epel: mirror.nes.co.id
 * extras: mirror.vbctv.in
 * updates: mirror.vbctv.in
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-80.el7.centos.1 will be installed
--> Processing Dependency: httpd-tools = 2.4.6-80.el7.centos.1 for package: httpd-2.4.6-80.el7.centos.1.x86_64
--> Processing Dependency: /etc/mime.types for package: httpd-2.4.6-80.el7.centos.1.x86_64
--> Processing Dependency: libaprutil-1.so.0()(64bit) for package: httpd-2.4.6-80.el7.centos.1.x86_64
--> Processing Dependency: libapr-1.so.0()(64bit) for package: httpd-2.4.6-80.el7.centos.1.x86_64
--> Running transaction check
---> Package apr.x86_64 0:1.4.8-3.el7_4.1 will be installed
---> Package apr-util.x86_64 0:1.5.2-6.el7 will be installed
---> Package httpd-tools.x86_64 0:2.4.6-80.el7.centos.1 will be installed
---> Package mailcap.noarch 0:2.1.41-2.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved


 Package                          Arch                        Version                                      Repository                    Size

Installing:
 httpd                            x86_64                      2.4.6-80.el7.centos.1                        updates                      2.7 M
Installing for dependencies:
 apr                              x86_64                      1.4.8-3.el7_4.1                              base                         103 k
 apr-util                         x86_64                      1.5.2-6.el7                                  base                          92 k
 httpd-tools                      x86_64                      2.4.6-80.el7.centos.1                        updates                       90 k
 mailcap                          noarch                      2.1.41-2.el7                                 base                          31 k

Transaction Summary

Install  1 Package (+4 Dependent packages)

Total download size: 3.0 M
Installed size: 10 M
Downloading packages:
(1/5): httpd-tools-2.4.6-80.el7.centos.1.x86_64.rpm                                                                    |  90 kB  00:00:01
(2/5): apr-util-1.5.2-6.el7.x86_64.rpm                                                                                 |  92 kB  00:00:01
(3/5): apr-1.4.8-3.el7_4.1.x86_64.rpm                                                                                  | 103 kB  00:00:01
(4/5): mailcap-2.1.41-2.el7.noarch.rpm                                                                                 |  31 kB  00:00:01
(5/5): httpd-2.4.6-80.el7.centos.1.x86_64.rpm                                                                          | 2.7 MB  00:00:02

Total                                                                                                         1.0 MB/s | 3.0 MB  00:00:02
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : apr-1.4.8-3.el7_4.1.x86_64                                                                                                 1/5
  Installing : apr-util-1.5.2-6.el7.x86_64                                                                                                2/5
  Installing : httpd-tools-2.4.6-80.el7.centos.1.x86_64                                                                                   3/5
  Installing : mailcap-2.1.41-2.el7.noarch                                                                                                4/5
  Installing : httpd-2.4.6-80.el7.centos.1.x86_64                                                                                         5/5
  Verifying  : mailcap-2.1.41-2.el7.noarch                                                                                                1/5
  Verifying  : httpd-tools-2.4.6-80.el7.centos.1.x86_64                                                                                   2/5
  Verifying  : apr-util-1.5.2-6.el7.x86_64                                                                                                3/5
  Verifying  : apr-1.4.8-3.el7_4.1.x86_64                                                                                                 4/5
  Verifying  : httpd-2.4.6-80.el7.centos.1.x86_64                                                                                         5/5

Installed:
  httpd.x86_64 0:2.4.6-80.el7.centos.1

Dependency Installed:
  apr.x86_64 0:1.4.8-3.el7_4.1   apr-util.x86_64 0:1.5.2-6.el7   httpd-tools.x86_64 0:2.4.6-80.el7.centos.1   mailcap.noarch 0:2.1.41-2.el7

Complete!

$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2018-09-29 02:50:18 IST; 11min ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 4594 (httpd)
   Status: "Total requests: 5; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/httpd.service
           ├─4594 /usr/sbin/httpd -DFOREGROUND
           ├─4595 /usr/sbin/httpd -DFOREGROUND
           ├─4596 /usr/sbin/httpd -DFOREGROUND
           ├─4598 /usr/sbin/httpd -DFOREGROUND
           ├─4599 /usr/sbin/httpd -DFOREGROUND
           └─4600 /usr/sbin/httpd -DFOREGROUND

Sep 29 02:50:18 puppetmaster.puppet.com systemd[1]: Starting The Apache HTTP Server...
Sep 29 02:50:18 puppetmaster.puppet.com systemd[1]: Started The Apache HTTP Server.

--

2) Once all installed and the exit status is success, the password line in the config file will be removed. So that you don't need to keep your password in the config file. Whenever you wish to do some steps, you can run this script, it will update the credentials in the config file. Mote: Please make sure to mention existing config file location.

Here is the example conf file after successfully installed Apache.

--

$ cat /etc/config_file.txt
Username: inesh.maran@domain.com
Password:

--
