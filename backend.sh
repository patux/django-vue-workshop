#!/usr/bin/env bash
dnf install tar curl dnf-plugins-core -y
dnf install python3 python3-pip -y
sudo -u vagrant python3 -m pip install  virtualenv
