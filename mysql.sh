#CentOS-8 Comes with MySQL 8 Version by default, However our application needs MySQL 5.7. So lets disable MySQL 8 version
#log_file=/tmp/expense.log
source common.sh
echo Disable Mysql 8 Version
dnf module disable mysql -y &>> $log_file
stat_check

#Setup the MySQL5.7 repo file
echo Copy Mysql Repo file
cp mysql.conf /etc/yum.repos.d/mysql.repo &>> $log_file
stat_check

#Install MySQL Server
echo Install Mysql server
dnf install mysql-community-server -y &>> $log_file
stat_check

#Start MySQL Service
echo Start Mysql service
systemctl enable mysqld &>> $log_file
systemctl start mysqld &>> $log_file
stat_check

#Next, We need to change the default root password in order to start using the database service. Use password ExpenseApp@1 or any other as per your choice
echo Setup Root password
mysql_root_password=$1
mysql_secure_installation --set-root-pass $mysql_root_password &>> $log_file
stat_check


