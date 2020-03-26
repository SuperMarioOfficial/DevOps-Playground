#!/bin/sh -eux
logz='cleanup.log'

echo "##############################################################################"
echo "# Provisioning                                                               #"| tee -a $logz
echo "##############################################################################"
apt-get -y -qq update  --fix-missing 
apt-get install resolvconf
apt-get install net-tools
apt-get install openssh-server
systemctl enable ssh
systemctl enable ssh.service
update-rc.d ssh defaults
systemctl enable ssh.socket
PATH=/usr/bin:/usr/sbin
echo "root:mindwarelab" | sudo chpasswd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

echo "##############################################################################"
echo "# Cleaning                                                                #" | tee -a $logz
echo "##############################################################################"

echo "-----Delete residuals-----" | tee -a $logz
dpkg -l | grep '^rc' | awk '{print $2}' | xargs dpkg --purge| tee -a $logz

echo "-----Truncate any logs that have built up during the install-----" | tee -a $logz
find /var/log -type f -exec truncate --size=0 {} \;| tee -a $logz
find /var/log/ -name "*.log" -exec rm -f {} \;  | tee -a $logz

echo "-----clear the history so our install isn't there-----" | tee -a $logz
export HISTSIZE=0 | tee -a $logz
unset HISTFIL
rm -f /root/.wget-hsts | tee -a $logz
ln -s /dev/null ~/.bash_history
