#!/bin/bash

set -e

#apt-get install git python3-pip
#sudo pip3 install pip --upgrade
#sudo pip3 install setuptools ipaddress pydotplus jinja2 --upgrade

#vagrant destroy -f
wget https://raw.githubusercontent.com/CumulusNetworks/topology_converter/master/topology_converter.py
chmod +x ./topology_converter.py
mkdir -p ./templates/
wget -O ./templates/Vagrantfile.j2 https://raw.githubusercontent.com/CumulusNetworks/topology_converter/master/templates/Vagrantfile.j2

# Write Vagrantfile for Virtualbox (Large Memory)
./topology_converter.py ./topology_large_memory.dot
cp ./Vagrantfile ./Vagrantfile-large-memory-vbox

# Write Vagrantfile for Libvirt (Large Memory)
./topology_converter.py ./topology_large_memory.dot -p libvirt
cp ./Vagrantfile ./Vagrantfile-large-memory-libvirt

# Write Vagrantfile for Libvirt
./topology_converter.py ./topology.dot -p libvirt
cp ./Vagrantfile ./Vagrantfile-kvm

# Write Vagrantfile for Virtualbox
./topology_converter.py ./topology.dot
cp ./Vagrantfile ./Vagrantfile-vbox

rm -rfv ./templates ./topology_converter.py ./topology_converter/
