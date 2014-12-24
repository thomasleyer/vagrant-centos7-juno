#!/bin/bash

#Set timezone Europe/Rome
sudo cp /usr/share/zoneinfo/Europe/Rome /etc/localtime

#Use DeltaRPM; /usr/bin/applydeltarpm
sudo yum -y install deltarpm.x86_64

#Install Epel repo; 7.2
sudo yum -y install epel-release

# Install RDO repo and packstack
sudo yum update -y
sudo yum install -y https://rdo.fedorapeople.org/rdo-release.rpm
sudo yum install -y openstack-packstack
sudo packstack --gen-answer-file=packstack-aio
sudo sed -i 's/CONFIG_CEILOMETER_INSTALL=y/CONFIG_CEILOMETER_INSTALL=n/g' packstack-aio
packstack --answer-file packstack-aio
sudo source /root/keystonerc_demo
nova keypair-add demokey > demokey.pem
chmod 600 demokey.pem
sudo cat /root/keystonerc_demo|grep PASSWORD
echo -e "Enjoy with Openstack !\n"
