#!/bin/bash

sudo dnf update -y

sudo dnf install ruby wget -y

cd /home/ec2-user

wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install

chmod +x ./install

sudo ./install auto

systemctl start codedeploy-agent

systemctl status codedeploy-agent

sleep 5