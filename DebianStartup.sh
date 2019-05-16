#! /bin/bash
apt-get update
apt-get -y install curl wget httpie nano unzip p7zip iftop mtr iputils-ping iputils-tracepath traceroute iproute2 dnsutils

# Skip translations
sh -c "echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations"
