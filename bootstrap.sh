#!/bin/bash

set -xeu
apt-get update -y
apt-get upgrade -y

apt-get install -y bind9 bind9utils bind9-doc

sed -i 's/^OPTIONS=.*/OPTIONS="-u bind -4"/' /etc/default/named

mkdir -p /var/lib/bind

cp /vagrant/config/named.conf.options /etc/bind/named.conf.options.backup

cp /vagrant/config/named.conf.options /etc/bind/
cp /vagrant/config/named.conf.local /etc/bind/
cp /vagrant/zones/raul.test.dns /var/lib/bind/
cp /vagrant/zones/raul.test.rev /var/lib/bind/

systemctl restart named
systemctl restart bind9
systemctl enable named
systemctl enable bind9

