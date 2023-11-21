#log_file=/tmp/expense.log
source common.sh
component=backend


echo Install Nodejs repos
dnf module disable nodejs
dnf module enable nodejs:18 -y
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi


echo Install NodeJs
dnf install nodejs -y &>> $log_file
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Copy Backend Service file
cp backend.service /etc/systemd/system/backend.service &>> $log_file
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Add Application user
useradd -M -N -s /sbin/nologin expense &>> $log_file
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Clean App content
rm -rf /app &>> $log_file
echo $?
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

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
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi


echo Start Backend Service
systemctl daemon-reload &>> $log_file
systemctl enable backend &>> $log_file
systemctl start backend &>> $log_file
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi


echo Install Mysql client
dnf install mysql -y &>> $log_file
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi



echo Load schema
mysql -h mysql.jaga-devops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> $log_file
echo $?
if [ $? -eq 0 ]
then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi