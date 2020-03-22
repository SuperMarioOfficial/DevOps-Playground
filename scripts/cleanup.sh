#!/bin/sh -eux
logz='cleanup.log'

echo "##############################################################################"
echo "# 01_Update System                                                           #" | tee -a $logz
echo "##############################################################################"
apt-get -y -qq update | tee -a $logz
apt-get install resolvconf
apt-get install net-tools
#apt-get update --fix-missing | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::='--force-confnew' | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -o Dpkg::Options::='--force-confnew' | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get autoremove -y -o Dpkg::Options::='--force-confnew' | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get -y -qq dist-upgrade | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get -y -qq install linux-headers-"$(uname -r)" | tee -a $logz

echo "##############################################################################"
echo "# 02_Cleaning                                                                #" | tee -a $logz
echo "##############################################################################"
echo"-----Delete linux-headers-----" | tee -a $logz
dpkg --list | awk '{ print $2 }' | grep 'linux-headers' | grep -vF "$(uname -r)" | xargs apt-get -y purge | tee -a $logz

echo "-----Delete linux-image-----" | tee -a $logz
dpkg --list | awk '{ print $2 }' | grep 'linux-image' | grep -vF "$(uname -r)" | xargs apt-get -y purge | tee -a $logz

echo "-----Delete residuals-----" | tee -a $logz
dpkg -l | grep '^rc' | awk '{print $2}' | xargs dpkg --purge| tee -a $logz

echo "-----Delete linux firmaware-----" | tee -a $logz
apt-get -y purge linux-firmware | tee -a $logz

echo "-----Delete X11 libraries-----" | tee -a $logz
apt-get -y purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6 | tee -a $logz

echo "-----Delete obsolete networking-----" | tee -a $logz
apt-get -y purge ppp pppconfig pppoeconf | tee -a $logz

echo "-----Delete oddities-----" | tee -a $logz
apt-get -y purge popularity-contest | tee -a $logz
apt-get -y purge installation-report | tee -a $logz

echo "-----Delete Packages-----" | tee -a $logz
apt-get -y autoremove | tee -a $logz
apt-get -y clean | tee -a $logz

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
#dd if=/dev/zero of=/EMPTY bs=1M || true | tee -a $logz
#rm -f /EMPTY | tee -a $logz

echo "-----clear the history so our install isn't there-----" | tee -a $logz
export HISTSIZE=0 | tee -a $logz
rm -f /root/.wget-hsts | tee -a $logz

echo "##############################################################################"
echo "# 04_Others                                                                  #"| tee -a $logz
echo "##############################################################################"
PATH=/usr/bin:/usr/sbin
echo "root:kosint" | sudo chpasswd
