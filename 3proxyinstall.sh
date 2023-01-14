version=0.8.13
apt-get update && apt-get -y upgrade
apt-get install gcc make git -y
wget --no-check-certificate -O 3proxy-${version}.tar.gz https://github.com/z3APA3A/3proxy/archive/${version}.tar.gz
tar xzf 3proxy-${version}.tar.gz
cd 3proxy-${version}
make -f Makefile.Linux
cd src
mkdir /etc/3proxy/
mv 3proxy /etc/3proxy/
cd /etc/3proxy/
wget --no-check-certificate https://github.com/dmshel/3proxy/raw/master/3proxy.cfg
chmod 600 /etc/3proxy/3proxy.cfg
mkdir /var/log/3proxy/
wget --no-check-certificate https://github.com/dmshel/3proxy/raw/master/.proxyauth
chmod 600 /etc/3proxy/.proxyauth
cd /etc/init.d/
wget --no-check-certificate  https://raw.github.com/dmshel/3proxy/master/3proxy
chmod  +x /etc/init.d/3proxy
update-rc.d 3proxy defaults
timedatectl set-timezone Asia/Tomsk
ufw allow 59999/tcp
ufw allow 58088/tcp
ufw allow 2022/tcp
ufw enable
/etc/init.d/3proxy start
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
echo port 2022 > /etc/ssh/sshd_config
service sshd restart
echo "username: $USERNAME"
echo "pass: $PASS"
echo ""