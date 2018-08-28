#!/bin/sh
#
# ---------------------------------------------------------------------
# debian auto setup software script.
# ---------------------------------------------------------------------
#

user="libra"
goUrl="http://pe5i98wzu.bkt.clouddn.com/go.tar.gz"
goName="go.tar.gz"
ideaUrl="http://pe5i98wzu.bkt.clouddn.com/ideaIU.tar.gz"
ideaName="idea.tar.gz"
golandUrl="http://pe5i98wzu.bkt.clouddn.com/goland.tar.gz"
golandName="goland.tar.gz"
jdkUrl="http://pe5i98wzu.bkt.clouddn.com/jdk-8.tar.gz"
jdkName="jdk.tar.gz"
sougouUrl="http://pe5i98wzu.bkt.clouddn.com/sogoupinyin_2.2.0.0108_amd64.deb"
sougouName="sougou.deb"

echo $USER
echo $user

apt-get update
apt-get install vim -y
apt-get install curl -y
apt-get install telnet -y
apt-get install net-tools -y
echo "export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin" >> /home/${user}/.bashrc

#download
if [ ! -d $goName ]; then
	echo "exists go"
else
	wget -O $goName $goUrl
fi

if [ ! -d $jdkName ]; then
	echo "exists jdk"
else
	wget -O $jdkName "jdk.tar.gz" $jdkUrl
fi

if [ ! -d $golandName ]; then
	echo "exists goland"
else
	wget -O $golandName "goland.tar.gz" $golandUrl
fi

if [ ! -d $ideaName ]; then
	echo "exists idea"
else
	wget -O $ideaName "idea.tar.gz" $ideaUrl
fi


if [ ! -d $sougouName ]; then
	echo "exists sougou input"
else
	wget -O $sougouName "sougou.deb" $sougouUrl
fi

#setup pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install shadowsocks

#setup guake
git clone https://github.com/Guake/guake.git
cd guake
./scripts/bootstrap-dev-debian.sh run make
make
make install

#setup sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
sudo apt-get install sublime-text -y


#中文输入法
apt-get install fcitx fcitx-tools fcitx-config* fcitx-frontend* fcitx-module* fcitx-ui-* presage
apt-get remove fcitx-module-kimpanel    # 移除多余的组件
apt-get install fcitx-pinyin            # 拼音
apt-get install fcitx-googlepinyin      # google拼音
dpkg -i sogoupinyin_2.2.0.0108_amd64.deb

#chome
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#dpkg -i  google-chrome-stable_current_amd64.deb
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >| sudo tee /etc/apt/sources.list.d/chrome.list
wget https://dl-ssl.google.com/linux/linux_signing_key.pub
apt-key add linux_signing_key.pub
apt-get update
apt-get install google-chrome-stable

#charles
wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add
sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
apt-get update
apt-get install charles-proxy


#setup docker
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
sudo groupadd docker
sudo usermod -aG docker $USER


