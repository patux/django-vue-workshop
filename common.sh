#!/usr/bin/env bash
dnf install net-tools git -y
sudo -u vagrant mkdir -p /vagrant/workshop
echo -e "Logged to $(hostname) !!\nThe work environment is in /vagrant/workshop\n" >/etc/motd
