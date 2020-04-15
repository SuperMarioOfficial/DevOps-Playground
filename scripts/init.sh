echo "##############################################################################"
echo "# Provisioning                                                               #"| 
echo "##############################################################################"
apt-get -y -qq update  --fix-missing 
apt-get install resolvconf
apt-get install net-tools
PATH=/usr/bin:/usr/sbin
echo "root:mindwarelab" | sudo chpasswd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
sh -c "echo 'mindwarelab ALL=NOPASSWD: ALL' >> /etc/sudoers"
