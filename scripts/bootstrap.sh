#!/usr/bin/env bash
#@Author Jason Slaughter
#Added missing repos and verified build on 1-16-2017
# exit if anything returns failure
set -e
cd /etc/yum.repos.d/
wget  https://yum.boundlessps.com/geoshape.repo
mkdir -p /var/lib/geonode/rogue_geonode/geoshape
cd /var/lib/geonode/rogue_geonode/
sudo wget https://github.com/vtadrones/geoshape-vagrant/archive/master.zip
sudo yum -y install unzip
sudo unzip master.zip
sudo cp -r geoshape-vagrant-master/ geoshape
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh epel-release-latest-6.noarch.rpm
rpm -Uvh http://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum -y install geoshape geoshape-geoserver elasticsearch postgis-postgresql95 rabbitmq-server-3.6.1

