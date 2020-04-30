# disable auto update notifications
sudo apt-get install gconf-editor
gconftool -s --type bool /apps/update-notifier/auto_launch false

# allow me to write and read from tty
sudo adduser $USER dialout

# disable services intercepting serial communication
sudo systemctl stop nvgetty
sudo systemctl disable nvgetty

# disable network over USB service created and used during setup with jetpack
sudo systemctl disable nv-l4t-usb-device-mode.service
sudo systemctl stop nv-l4t-usb-device-mode.service

# allow to running /opt/nvidia/jetson-io/jetson-io.py GPIO configuration tool
# see a note at https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/hw_setup_jetson_io.html
sudo find /opt/nvidia/jetson-io/ -mindepth 1 -maxdepth 1 -type d -exec touch {}/__init__.py \;


# nvpmodel determines what performance range is allowed, 
# and jetson_clocks.sh is switching to max rate"
sudo nvpmodel -m 0
#sudo touch /etc/systemd/system/jetson_clocks.service
#sudo zsh -c 'echo "[Unit]" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "Description=Jetson Clocks Service" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "After=nv.service nvpmodel.service" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "Requires=nv.service" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "Before=graphical.target" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "Before=gdm3.service lightdm.service" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "[Service]" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "Type=simple" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "ExecStart=/usr/bin/jetson_clocks" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "Restart=always" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "[Install]" >> /etc/systemd/system/jetson_clocks.service'
#sudo zsh -c 'echo "WantedBy=multi-user.target" >> /etc/systemd/system/jetson_clocks.service'
#sudo systemctl enable jetson_clocks.service
#sudo systemctl start jetson_clocks.service
sudo -H pip install jetson-stats
sudo systemctl enable jetson_performance.service
sudo systemctl start jetson_performance.service