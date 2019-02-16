#!/bin/bash -xe
function step { echo -e "\n: \e[32m$1\e[0m\n" ; }

step 'Disable Extra Features'
systemctl disable postfix

step 'Disable SELinux'
setenforce 0
echo 'SELINUX=disabled
SELINUXTYPE=targeted' > /etc/sysconfig/selinux

step 'Extra Remote Mirror'
yum install -y epel-release
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.0.130-1.x86_64.rpm

step 'Install Packages'
yum update -y
yum install -y \
  vim fish zsh tmux2u git2u wget aria2 rsync htop tree bsdtar unzip \
  python36u python36u-devel python36u-pip python2-pip python2-devel \
  systemd-networkd systemd-resolved nftables ntp mdadm nfs-utils \
  pciutils psmisc lm_sensors lsof tcpdump nmap net-snmp net-snmp-utils \
  cuda cmake3 libtool autogen patch perf iperf \
  darkhttpd yum-utils rpm-build gdisk smartmontools
yum groupinstall -y 'x11'

step 'Config'
timedatectl set-timezone "Asia/Taipei"
sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config

step 'Network'
systemctl disable network
systemctl disable NetworkManager
systemctl disable NetworkManager-wait-online
systemctl disable firewalld
systemctl enable --now systemd-networkd
systemctl enable --now systemd-resolved
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl enable --now nftables

step 'Done'
