#! /bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install nodejs npm git nginx -y
cd /home/ec2-user
git clone https://github.com/Lohan21/projetoLogS3.git
sudo chmod 707 projetoLogS3
sudo chmod 707 projetoLogS3/src
sudo cp projetoLogS3/config/*.conf /etc/nginx/
cd projetoLogS3/src
sudo npm install express request-ip aws-sdk
