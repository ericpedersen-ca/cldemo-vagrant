#!/bin/bash

echo "#################################"
echo "  Running Switch Post Config (config_switch.sh)"
echo "#################################"
sudo su


#Replace existing network interfaces file
echo -e "auto lo" > /etc/network/interfaces
echo -e "iface lo inet loopback\n\n" >> /etc/network/interfaces

#Add oob interface
echo -e "\n\nauto eth0" >> /etc/network/interfaces
echo -e "iface eth0 inet dhcp\n\n" >> /etc/network/interfaces

#Add vagrant interface
echo -e "\n\nauto vagrant" >> /etc/network/interfaces
echo -e "iface vagrant inet dhcp\n\n" >> /etc/network/interfaces

## Convenience code. This is normally done in ZTP.

# Make DHCP occur without delays
echo "retry 1;" >> /etc/dhcp/dhclient.conf


echo "#################################"
echo "   Finished"
echo "#################################"
