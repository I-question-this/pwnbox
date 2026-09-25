#!/bin/bash

# Upgrade system
apt update && apt upgrade -y

# Install some essentials
apt install --no-install-recommends -y build-essential locales man-db git wget curl python2.7 python3 python3-dev python3-pip python3-venv python3-setuptools netcat-openbsd ruby ruby-dev sudo jq nmap cmake && \
	apt install --no-install-recommends -y python-is-python3

# Install pip2.7
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py -O /tmp/get-pip.py && python2.7 /tmp/get-pip.py && rm /tmp/get-pip.py

# Install wheel to allow faster pip installs
pip3 install wheel
python2.7 -m pip install wheel

# Remove pip2.7 default alias
rm /usr/local/bin/pip

# Set the locale
sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
	locale-gen && \
	locale -a

# Install SSH
echo "root:toor" | chpasswd && \
	apt install --no-install-recommends -y openssh-server openssh-client && \
	chmod 600 /etc/ssh/ssh_host_* && \
	mkdir -p /var/run/sshd

# Setting up the shell
apt install --no-install-recommends -y zsh grc command-not-found
chsh -s /bin/zsh

# Setting up X11 Forwarding
apt install -y xauth
touch /root/.Xauthority

# Set up the shell
touch /root/.hushlogin
cp /setup/banner.sh /etc/profile.d/banner.sh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install ZSH plugins
git clone --single-branch --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --single-branch --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Powerlevel10k
git clone --single-branch --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy and use custom .zshrc
cp /setup/files/.zshrc /root/.zshrc
cp /setup/files/.p10k.zsh /root/.p10k.zsh
