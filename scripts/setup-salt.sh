#!/bin/bash

# Install salt-master and salt-minion
wget -O bootstrap_salt.sh https://bootstrap.saltstack.com
sudo sh bootstrap_salt.sh -M

# Remove salt default configs
sudo rm -fr /srv/salt

# Copy base config
sudo git clone https://github.com/mothbe/salt-base.git /srv/salt/base

# Copy salt-formula to base environment
sudo git clone https://github.com/mothbe/salt-formula.git /srv/salt/base/formulas/salt-formula

sudo cp /srv/salt/base/scripts/master.conf /etc/salt/master.d/
sudo pkill salt-master
sudo /etc/init.d/salt-master start

# Accept all keys #
sleep 15 #give the minion a few seconds to register
sudo salt-key -y -A
