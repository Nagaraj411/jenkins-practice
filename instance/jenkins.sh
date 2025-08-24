#!/bin/bash

#resize disk from 20GB to 50GB
growpart /dev/nvme0n1 4

# Resize the logical volumes
lvextend -L +10G /dev/RootVG/rootVol
lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -l +100%FREE /dev/mapper/RootVG-varTmpVol

# Resize the filesystem
xfs_growfs /
xfs_growfs /var/tmp
xfs_growfs /var

# Install jenkins
curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# Add required dependencies for the jenkins package

yum install fontconfig java-21-openjdk -y
yum install jenkins -y
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins
