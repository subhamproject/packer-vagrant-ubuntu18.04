#!/bin/bash -eux

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# Create user
groupadd --gid 1000 rcxdev
useradd --uid 1000 --gid rcxdev --shell /bin/bash --create-home rcxdev
echo "rcxdev:rcxdev" | chpasswd

#Add rcxdev user to sudoers.
echo "rcxdev        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

#Set hostname
hostnamectl set-hostname rcxdev

#Configure swap memory
fallocate -l 8G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile
[ $? -eq 0 ] && echo "/swapfile  swap  swap  defaults  0  0" >> /etc/fstab


#configure repository
apt-get update -y
apt-get -y install software-properties-common
apt-add-repository ppa:ansible/ansible -y

# Install Ansible.
apt-get -y update
apt-get -y install ansible
apt-get install ifupdown -y