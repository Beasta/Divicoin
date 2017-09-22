#!/bin/bash

# Install PIVX
apt-get update
sudo apt-get install build-essential libtool autotools-dev autoconf pkg-config libssl-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
apt-get install wget nano vim-common -y
mkdir ~/pivx
cd ~/pivx
wget https://github.com/PIVX-Project/PIVX/releases/download/v2.2.1/pivx-2.2.1-x86_64-linux-gnu.tar.gz
tar xvzf pivx-2.2.1-x86_64-linux-gnu.tar.gz
mkdir ~/.pivx/
cp pivx-2.2.1/bin/pivx-cli ~/.pivx
cp pivx-2.2.1/bin/pivxd ~/.pivx
cp -v pivx-2.2.1/bin/* /usr/local/bin

CreatePivxConf() {
echo "rpcuser=pivxrpc" >> ~/.pivx/pivx.conf
echo -e "rpcpassword=$(xxd -l 16 -p /dev/urandom)" >> ~/.pivx/pivx.conf 
echo "rpcallowip=127.0.0.1" >> ~/.pivx/pivx.conf
echo "listen=0" >> ~/.pivx/pivx.conf
echo "server=1" >> ~/.pivx/pivx.conf
echo "daemon=1" >> ~/.pivx/pivx.conf
echo "logtimestamps=1" >> ~/.pivx/pivx.conf
echo "maxconnections=256" >> ~/.pivx/pivx.conf
}

# Add PIVX startup cron at boot 
echo "@reboot cd /root/.pivx && ./pivxd" >> /var/spool/cron/crontabs/root

CreatePivxConf

# Start PIVX service
pivxd
