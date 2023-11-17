#The frontend is the service in Expense to serve the web content over Nginx. This will have the webframe for the web application.

# This is a static content and to serve static content we need a web server. This server

#Developer has chosen Nginx as a web server and thus we will install Nginx Web Server.

#Install Nginx
echo Installing Nginx
dnf install nginx -y >> /tmp/expense.log

#Start & Enable Nginx service
echo Enable and start Nginx
systemctl enable nginx >> /tmp/expense.log
systemctl start nginx >> /tmp/expense.log


#Copying configuration
echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf >> /tmp/expense.log

#Remove the default content that web server is serving.
echo Removing old nginx content
rm -rf /usr/share/nginx/html/* >> /tmp/expense.log

#Download the frontend content
echo Download Frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

#Extract the frontend content.

cd /usr/share/nginx/html

echo Exract Frontend code
unzip /tmp/frontend.zip >> /tmp/expense.log

#Note

#Ensure you replace the localhost with the actual ip address of backend component server. Word localhost is just used to avoid the failures on the Nginx Server.

#Restart Nginx Service to load the changes of the configuration.
echo Restart Nginx server
systemctl restart nginx >> /tmp/expense.log

