#!/usr/bin/env bash

# exit if anything returns failure
set -e
cd /etc/yum.repos.d/
wget  https://yum.boundlessps.com/geoshape.repo
mkdir -p /var/lib/geonode/rogue_geonode/geoshape
mkdir -p /var/lib/geonode/lib/python2.7/site-packages/
cd /var/lib/geonode/rogue_geonode/
sudo wget https://github.com/vtadrones/rogue_geonode/archive/master.zip -O geoshape.zip
sudo wget https://github.com/vtadrones/geonode/archive/master.zip -O geonode.zip
sudo yum -y install unzip
sudo unzip geoshape.zip
sudo unzip geonode.zip
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh epel-release-latest-6.noarch.rpm
rpm -Uvh http://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum -y install geoshape geoshape-geoserver elasticsearch postgis-postgresql95 rabbitmq-server-3.6.1
#Required path
#geonode home - /var/lib/geonode/geonode
#rogue_geonode - /var/lib/geonode/rogue_geonode
sudo cp -r /var/lib/geonode/rogue_geonode/geonode-master/geonode /var/lib/geonode/
sudo cp -r /var/lib/geonode/rogue_geonode/rogue_geonode-master/geoshape .
wget -O geoserver.zip https://github.com/vtadrones/geoserver/archive/master.zip
unzip geoserver.zip
echo "Unzipped geoserver"
#sudo service tomcat8 stop
echo "tomcat stopped"
cd geoserver-master/src/Production/
sudo rm -rf /var/lib/tomcat8/webapps/geoserver
echo "Removed old files"
ls -la /var/lib/tomcat8/webapps/
sudo mv geoserver.war /var/lib/tomcat8/webapps/
echo "Added war"
sudo service tomcat8 start
echo "Install complete"
service tomcat8 status
cd /var/log/tomcat8/
echo "Started on http://192.168.10.221:8080/geoserver/web"
echo "Default Username: admin"
echo "Default: geoserver"
