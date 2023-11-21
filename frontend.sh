#log_file=/tmp/expense.log
source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y &>> $log_file


echo Enable and start Nginx
systemctl enable nginx &>> $log_file
systemctl start nginx &>> $log_file



echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file


echo Removing old nginx content
rm -rf /usr/share/nginx/html/* &>> $log_file

cd /usr/share/nginx/html


#Added below 2 lines in common.sh function download_and_extract. so commenting them
#echo Download Frontend code
#curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>> $log_file

#Added below 2 lines in common.sh function download_and_extract. so commenting them
#echo Exract Frontend code
#unzip /tmp/frontend.zip &>> $log_file
download_and_extract

echo Restart Nginx server
systemctl restart nginx &>> $log_file

