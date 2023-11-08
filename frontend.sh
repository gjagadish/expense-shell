#The frontend is the service in Expense to serve the web content over Nginx. This will have the webframe for the web application.

# This is a static content and to serve static content we need a web server. This server

#Developer has chosen Nginx as a web server and thus we will install Nginx Web Server.

#Install Nginx

dnf install nginx -y

#Start & Enable Nginx service

systemctl enable nginx
systemctl start nginx


#Copying configuration
cp expense.conf /etc/nginx/default.d/expense.conf

#Remove the default content that web server is serving.

rm -rf /usr/share/nginx/html/*

#Download the frontend content

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

#Extract the frontend content.

cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#Note

#Ensure you replace the localhost with the actual ip address of backend component server. Word localhost is just used to avoid the failures on the Nginx Server.

#Restart Nginx Service to load the changes of the configuration.

systemctl restart nginx

