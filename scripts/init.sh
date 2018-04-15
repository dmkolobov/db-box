#!/bin/bash

# first, turn of automatic apt-get updates and kill all running apt processes.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
pkill apt.systemd.daily
pkill apt-get

export DEBIAN_FRONTEND=noninteractive

# allow persistance of 'http_proxy', 'https_proxy', and 'ftp_proxy' env vars 
# across uses of 'sudo'. 
echo 'Defaults env_keep = "http_proxy https_proxy ftp_proxy"' >> /etc/sudoers