#!/bin/sh -eux

wget http://download.virtualbox.org/virtualbox/4.3.8/VBoxGuestAdditions_4.3.8.iso
mkdir /media/VBoxGuestAdditions
mount -o loop,ro VBoxGuestAdditions_4.3.8.iso /media/VBoxGuestAdditions
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_4.3.8.iso
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions