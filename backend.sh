#Backend service is responsible for adding the given values to database. Backend service is written in NodeJS, Hence we need to install NodeJS.
#Install NodeJS, By default NodeJS 10 is available, We would like to enable 18 version and install list.

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y


cp backend.service /etc/systemd/system/backend.service
#Add application User

useradd -M -N -s /sbin/nologin expense

#Lets setup an app directory.
rm -rf /app
mkdir /app

#Download the application code to created app directory.

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip

#Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
#Lets download the dependencies.

npm install



systemctl daemon-reload
systemctl enable backend
systemctl start backend

#For this application to work fully functional we need to load schema to the Database.

dnf install mysql -y

mysql -h mysql.jaga-devops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql