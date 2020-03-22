#!/bin/sh -eux

echo "allow-hotplug eth0 iface eth0 inet dhcp" >> /etc/network/interfaces

echo "auto eth1 iface eth1 inet static address 10.152.152.100 netmask 255.255.192.0 gateway 10.152.152.10" >> /etc/network/interfaces

nmcli  connection  add con-name Tor type Ethernet autoconnect no ipv4.addresses 10.152.152.11/18 ipv4.gateway 10.152.152.10 ipv4.method manual

systemctl start resolvconf.service
systemctl enable resolvconf.service
echo "nameserver 10.152.152.10" >> /etc/resolv.conf
resolvconf -u
#echo "[ifupdown] managed=true" >> /etc/NetworkManager/NetworkManager.conf
