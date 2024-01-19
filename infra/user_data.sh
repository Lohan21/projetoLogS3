#! /bin/bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install nodejs npm git nginx -y
cd /home/ec2-user
mkdir projeto
sudo chmod 707 projeto
cd projeto
sudo npm install express request-ip aws-sdk