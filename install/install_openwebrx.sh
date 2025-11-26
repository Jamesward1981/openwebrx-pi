#!/bin/bash

# Update system
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y python3 python3-pip python3-numpy python3-setuptools \
git cmake libfftw3-dev libusb-1.0-0-dev rtl-sdr sox

# Build csdr (needed by OpenWebRX)
git clone https://github.com/simonyiszk/csdr.git
cd csdr
mkdir build
cd build
cmake ..
make
sudo make install
cd ~

# Install rtl-sdr rules
sudo cp ./csdr/rtl_sdr.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

# Install OpenWebRX
git clone https://github.com/jketterl/openwebrx.git
cd openwebrx
pip3 install -r requirements.txt

echo "-------------------------------"
echo " OpenWebRX installation finished"
echo " Run with: python3 openwebrx/openwebrx.py"
echo "-------------------------------"

