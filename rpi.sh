#sudo bash '/media/psf/AllFiles/Users/elaouby/Desktop/RPI/rpi.sh'
xset s noblank
xset s off
xset -dpms
(echo 3578; echo 3578) | passwd elaouby
sudo hostnamectl set-hostname elaouby-rpi
echo "deb [trusted=yes] https://archive.raspberrypi.org/debian bullseye main" >> /etc/apt/sources.list
echo "deb [trusted=yes] https://downloads.plex.tv/repo/deb public main" >> /etc/apt/sources.list
echo "root	ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "%admin	ALL=(ALL) ALL" >> /etc/sudoers
echo "%sudo	ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "elaouby	ALL=(ALL) ALL" >> /etc/sudoers
echo "FallbackNTP=216.239.35.0 216.239.35.4" >> /etc/systemd/timesyncd.conf
sed -i '12i\'"AutomaticLoginEnable = true" /etc/gdm3/daemon.conf
sed -i '13i\'"AutomaticLogin = elaouby" /etc/gdm3/daemon.conf
sudo timedatectl set-ntp true
sudo cp -r /media/psf/AllFiles/Users/elaouby/Desktop/RPI/50-local.d /etc/polkit-1/localauthority/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7FA3303E
sudo apt install curl -y
sudo curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo curl http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | sudo apt-key add -
sudo apt-get check
sudo apt autoremove
sudo apt-get autoclean
sudo apt-get clean
sudo apt update
wget https://download.teamviewer.com/download/linux/teamviewer_arm64.deb
sudo apt install apt-transport-https -y
sudo apt install raspi-config -y
sudo apt install plexmediaserver -y
sudo apt install rpi-imager -y
sudo apt install ufw -y
sudo apt install xrdp -y
sudo apt install xserver-xorg-core -y
sudo apt install xserver-xorg-input-all -y
sudo apt install xorgxrdp -y
sudo apt install vlc -y
sudo apt install ./teamviewer_arm64.deb -y
sudo rm ./teamviewer_arm64.deb
sudo apt install exfat-fuse -y
sudo apt install exfat-utils -y
sudo apt install ntfs-3g -y
sudo apt install default-jdk -y
sudo apt install gnome-online-accounts -y
sudo apt install samba -y
sudo apt full-upgrade -y
sudo apt-get check
sudo apt autoremove
sudo apt-get autoclean
sudo apt-get clean
sed -i '12i\'"Unset DBUS_SESSION_ADDRESS" /etc/xrdp/startwm.sh
sed -i '13i\'"Unset XDG_RUNTIME_DIR" /etc/xrdp/startwm.sh
sed -i '14i\''export $(dbus-launch)' /etc/xrdp/startwm.sh
sudo ufw allow from 0.0.0.0/0 to any port 3389
sudo ufw allow from 0.0.0.0/0 to any port 32400
sudo ufw allow from 0.0.0.0/0 to any port 548
sudo ufw allow from 0.0.0.0/0 to any port 427
sudo ufw allow from 0.0.0.0/0 to any port 4700
sudo ufw allow from 0.0.0.0/0 to any app samba
(echo 3578; echo 3578) | smbpasswd -a -s elaouby
echo '[global]' > /etc/samba/smb.conf
echo '	workgroup = WORKGROUP' >> /etc/samba/smb.conf
echo '	netbios name = elaouby-rpi' >> /etc/samba/smb.conf
echo '	wins support = yes' >> /etc/samba/smb.conf
echo '	min protocol = SMB2' >> /etc/samba/smb.conf
echo '	server role = standalone server' >> /etc/samba/smb.conf
echo '	obey pam restrictions = yes' >> /etc/samba/smb.conf
echo '	unix password sync = yes' >> /etc/samba/smb.conf
echo '	passwd program = /usr/bin/passwd %u' >> /etc/samba/smb.conf
echo '	passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .' >> /etc/samba/smb.conf
echo '	pam password change = yes' >> /etc/samba/smb.conf
echo '	map to guest = bad user' >> /etc/samba/smb.conf
echo '	usershare allow guests = yes' >> /etc/samba/smb.conf
echo '	guest only = yes' >> /etc/samba/smb.conf
echo '	writable = yes' >> /etc/samba/smb.conf
echo '	read only = no' >> /etc/samba/smb.conf
echo '	create mask = 777' >> /etc/samba/smb.conf
echo '	directory mask = 777' >> /etc/samba/smb.conf
echo '	browseable = yes' >> /etc/samba/smb.conf
echo '	follow symlinks = yes' >> /etc/samba/smb.conf
echo '	wide links = yes' >> /etc/samba/smb.conf
echo '	force user = root' >> /etc/samba/smb.conf
echo '[root]' >> /etc/samba/smb.conf
echo '	path=/' >> /etc/samba/smb.conf
echo '[Plex]' >> /etc/samba/smb.conf
echo '	path=/plex' >> /etc/samba/smb.conf
echo '[TimeMachine]' >> /etc/samba/smb.conf
echo '	path=/timemachine' >> /etc/samba/smb.conf
echo '	vfs objects = acl_xattr catia fruit streams_xattr' >> /etc/samba/smb.conf
echo '	fruit:metadata = stream' >> /etc/samba/smb.conf
echo '	fruit:model = MacSamba' >> /etc/samba/smb.conf
echo '	fruit:posix_rename = yes' >> /etc/samba/smb.conf
echo '	fruit:veto_appledouble = no' >> /etc/samba/smb.conf
echo '	fruit:wipe_intentionally_left_blank_rfork = yes' >> /etc/samba/smb.conf
echo '	fruit:delete_empty_adfiles = yes' >> /etc/samba/smb.conf
echo '	fruit:aapl = yes' >> /etc/samba/smb.conf
echo '	fruit:time machine = yes' >> /etc/samba/smb.conf
echo '	server min protocol = SMB2' >> /etc/samba/smb.conf
echo '	browseable = no' >> /etc/samba/smb.conf
#sudo mkdir -p /plex
#sudo mkdir -p /timemachine
sudo systemctl stop plexmediaserver.service
sudo rm -r /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server
sudo ln -s /usbplex /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server
sudo ln -s /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server /plex
sudo ln -s /usbtimemachine /timemachine
sudo chown elaouby /plex
sudo chown elaouby /timemachine
sudo chown elaouby /usbplex
sudo chown elaouby /usbtimemachine
sudo chown elaouby /var/lib/plexmediaserver
sudo find /plex -type d -exec chmod 777 {} \;
sudo find /plex -type f -exec chmod 777 {} \;
sudo find /timemachine -type d -exec chmod 777 {} \;
sudo find /timemachine -type f -exec chmod 777 {} \;
sudo find /usbplex -type d -exec chmod 777 {} \;
sudo find /usbplex -type f -exec chmod 777 {} \;
sudo find /usbtimemachine -type d -exec chmod 777 {} \;
sudo find /usbtimemachine -type f -exec chmod 777 {} \;
sudo find /var/lib/plexmediaserver -type d -exec chmod 777 {} \;
sudo find /var/lib/plexmediaserver -type f -exec chmod 777 {} \;
sudo raspi-config nonint do_hostname elaouby-rpi
sudo raspi-config nonint do_change_locale en_US.UTF-8
sudo raspi-config nonint do_boot_splash 1
sudo raspi-config nonint do_blanking 1
sudo raspi-config nonint do_change_timezone Asia/Qatar
sudo raspi-config nonint do_configure_keyboard us
sudo raspi-config nonint do_wifi_country QA
sudo raspi-config nonint do_ssh 0
curl https://download.argon40.com/argon1.sh | bash
crontab -l | { cat; echo "05 6 * * * sudo apt update ; sudo apt full-upgrade -y ; sudo apt-get check ; sudo apt autoremove ; sudo apt-get autoclean ; sudo apt-get clean ; sudo reboot"; } | crontab -
crontab -l | { cat; echo "@reboot xset -dpms ; xset s noblank ; xset s off ; sudo systemctl enable ssh ; sudo systemctl start ssh ; sudo systemctl enable plexmediaserver.service ; sudo systemctl start plexmediaserver.service ; sudo systemctl enable raspi-config.service ; sudo systemctl start raspi-config.service ; sudo systemctl enable xrdp.service ; sudo systemctl start xrdp.service ; sudo systemctl enable xrdp-sesman.service ; sudo systemctl start xrdp-sesman.service ; sudo teamviewer --daemon start ; sudo systemctl enable teamviewerd.service ; sudo systemctl start teamviewerd.service ; systemctl enable smbd ; systemctl start smbd"; } | crontab -
sudo usermod -a -G adm elaouby
sudo usermod -a -G root elaouby
sudo usermod -a -G ssl-cert elaouby
sudo usermod -a -G sudo elaouby
sudo usermod -a -G adm xrdp
sudo usermod -a -G root xrdp
sudo usermod -a -G ssl-cert xrdp
sudo usermod -a -G sudo xrdp
sudo reboot