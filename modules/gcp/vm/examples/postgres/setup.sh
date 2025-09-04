#!/bin/bash

# get env variables
. ./setup.env

# install tools
echo "apt-get updating"
sudo apt-get update
echo "installing tools..."
sudo apt-get install -y curl git

sudo apt-get install -y unzip

sudo apt install -y jq

echo " ******* install postgresql ******* "

sudo apt install postgresql postgresql-contrib -y

echo " ******* confirm postgresql installation ******* "
sudo systemctl start postgresql.service

echo """
******* to view postgresql logs, run the following: ******* 

sudo journalctl -u postgresql

"""

echo " ******* configure postgresql logging ******* "
sudo cp ./data/postgresql.conf /etc/postgresql/16/main/postgresql.conf
sudo systemctl restart postgresql.service

echo " ******* create database ******* "
sudo sed -i.bak "s/__DATABASE_NAME__/$DATABASE_NAME/g" ./data/prepare_postgresql.sql

sudo -u postgres psql -a -f ./data/prepare_postgresql.sql

# cofirm setup complete
echo " ******* SETUP COMPLETE ******* "