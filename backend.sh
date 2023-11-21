#log_file=/tmp/expense.log
source common.sh
component=backend

type npm &>> $log_file
if [ $? -ne 0 ]
then
  echo Install Nodejs repos
  dnf module disable nodejs
  dnf module enable nodejs:18 -y
  #echo $?
  stat_check
  echo Install NodeJs
  dnf install nodejs -y &>> $log_file
  #echo $?
  stat_check
fi

echo Copy Backend Service file
cp backend.service /etc/systemd/system/backend.service &>> $log_file
#echo $?
stat_check

echo Add Application user
id expense &>> $log_file
if [  $? -ne 0 ]
then
 useradd -M -N -s /sbin/nologin expense &>> $log_file
fi
#echo $?
stat_check

echo Clean App content
rm -rf /app &>> $log_file
#echo $?
stat_check

mkdir /app &>> $log_file

cd /app

#Added below 2 lines in common.sh function download_and_extract. so commenting them
#echo Download App Content
#curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>> $log_file

#Added below 2 lines in common.sh function download_and_extract. so commenting them
#echo Extract App content
#unzip /tmp/backend.zip &>> $log_file

download_and_extract

echo Download Dependencies
npm install &>> $log_file
#echo $?
stat_check

echo Start Backend Service
systemctl daemon-reload &>> $log_file
systemctl enable backend &>> $log_file
systemctl start backend &>> $log_file
#echo $?
stat_check

echo Install Mysql client
dnf install mysql -y &>> $log_file
#echo $?
stat_check



echo Load schema
mysql_root_password=$1
mysql -h mysql.jaga-devops.online -uroot -p$mysql_root_password < /app/schema/backend.sql &>> $log_file
#echo $?
stat_check