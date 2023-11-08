#CentOS-8 Comes with MySQL 8 Version by default, However our application needs MySQL 5.7. So lets disable MySQL 8 version

dnf module disable mysql -y

#Setup the MySQL5.7 repo file
cp mysql.conf /etc/yum.repos.d/mysql.repo

#Install MySQL Server
dnf install mysql-community-server -y

#Start MySQL Service
systemctl enable mysqld
systemctl start mysqld

#Next, We need to change the default root password in order to start using the database service. Use password ExpenseApp@1 or any other as per your choice
mysql_secure_installation --set-root-pass ExpenseApp@1



