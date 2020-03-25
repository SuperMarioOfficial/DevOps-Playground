#!/bin/sh -eux
logz='cleanup.log'

echo "##############################################################################"
echo "# 02_Cleaning                                                                #"
echo "##############################################################################"
sudo apt-get clean -y

echo "-----Delete residuals-----" | tee -a $logz
dpkg -l | grep '^rc' | awk '{print $2}' | xargs dpkg --purge| tee -a $logz

echo "-----Truncate any logs that have built up during the install-----" | tee -a $logz
find /var/log -type f -exec truncate --size=0 {} \;| tee -a $logz
find /var/log/ -name "*.log" -exec rm -f {} \;  | tee -a $logz

echo "-----Cleaning up dpkg backup files-----" | tee -a $logz
find /usr -name "*.pyc" -print0 | xargs -0r rm -rf
find /var/cache/apt -type f -print0 | xargs -0r rm -rf
find /var/cache/debconf -type f -print0 | xargs -0r rm -rf
find /usr/share/man -type f -print0 | xargs -0r rm -rf
find /usr/share/doc -type f -print0 | xargs -0r rm -rf
find /usr/share/locale -type f -print0 | xargs -0r rm -rf

echo "-----Blank netplan machine-id (DUID) so machines get unique ID generated on boot.-----" | tee -a $logz
truncate -s 0 /etc/machine-id | tee -a $logz

echo "-----Zero out the free space to save space in the final image-----" | tee -a $logz
dd if=/dev/zero of=/EMPTY bs=1M || true | tee -a $logz
rm -f /EMPTY | tee -a $logz

echo "-----clear the history so our install isn't there-----" | tee -a $logz
export HISTSIZE=0 | tee -a $logz
unset HISTFILE
rm -f /root/.wget-hsts | tee -a $logz

echo "##############################################################################"
echo "# 04_Others                                                                  #"
echo "##############################################################################"
apt-get -y -qq update --fix-missing 
apt-get install resolvconf
apt-get install net-tools
apt-get install openssh-server
systemctl enable ssh
systemctl enable ssh.service
systemctl start ssh
systemctl enable sshd
systemctl enable sshd.service 
systemctl start sshd
update-rc.d ssh defaults
systemctl enable ssh.socket
PATH=/usr/bin:/usr/sbin
echo "root:mindwarelab" | sudo chpasswd
sh -c "echo 'mindwarelab ALL=NOPASSWD: ALL' >> /etc/sudoers"
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

ln -s /dev/null ~/.bash_history && history -c && exit
