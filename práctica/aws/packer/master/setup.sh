#!/bin/bash

# echo "Install Jenkins stable release"
# yum remove -y java
# yum install -y java-1.8.0-openjdk
# wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
# rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
# yum install -y jenkins
# chkconfig jenkins on
# service jenkins start

sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo dnf install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins

sudo yum install git -y
sudo mkdir /var/lib/jenkins/.ssh
sudo touch /var/lib/jenkins/.ssh/known_hosts
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
sudo mv /tmp/jenkins-workers /var/lib/jenkins/.ssh/jenkins-workers
sudo chmod 600 /var/lib/jenkins/.ssh/jenkins-workers
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/jenkins-workers

# sudo mkdir -p /var/lib/jenkins/init.groovy.d
# sudo mv /tmp/*.groovy /var/lib/jenkins/init.groovy.d/
sudo mkdir -p /var/lib/jenkins/casc_configs
sudo mv /tmp/*.yaml /var/lib/jenkins/casc_configs/
sudo export CASC_JENKINS_CONFIG=/var/lib/jenkins/casc_configs

sudo mv /tmp/jenkins /etc/sysconfig/jenkins
sudo chmod +x /tmp/install-plugins.sh
sudo bash /tmp/install-plugins.sh

sudo systemctl start jenkins