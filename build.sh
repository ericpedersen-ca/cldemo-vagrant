#!/bin/bash

set -e

wget -O requirements.txt https://gitlab.com/cumulus-consulting/tools/topology_converter/raw/master/requirements.txt?inline=false
pip3 install -r ./requirements.txt

#vagrant destroy -f
wget -O ./topology_converter.py https://gitlab.com/cumulus-consulting/tools/topology_converter/raw/master/topology_converter.py?inline=false
chmod +x ./topology_converter.py
mkdir -p ./templates/
wget -O ./templates/Vagrantfile.j2 https://gitlab.com/cumulus-consulting/tools/topology_converter/raw/master/templates/Vagrantfile.j2?inline=false

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

rm -rfv ./templates ./topology_converter.py ./topology_converter/ requirements.txt
