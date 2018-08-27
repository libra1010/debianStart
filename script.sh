#!/bin/sh
#
# ---------------------------------------------------------------------
# debian auto setup software script.
# ---------------------------------------------------------------------
#

apt-get update
apt-get install vim -y
apt-get install curl -y
apt-get install telnet -y
apt-get install net-tools -y
echo "export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin" >> ~/.bashrc
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install --user guake
pip install shadowsocks

apt-get remove docker docker-engine docker.io -y
apt-get update
apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
 add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update -y
apt-get install docker-ce -y