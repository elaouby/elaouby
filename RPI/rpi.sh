#curl http://files.elaouby.com/rpi/rpi.sh | sudo bash -v
sudo apt install curl -y
#curl https://download.argon40.com/argon1.sh | bash
#(echo y; echo 1) | argonone-config
#(echo y; echo 1; echo 1) | argonone-ir
#curl https://gitlab.com/DarkElvenAngel/argononed/-/raw/master/get_argononed.sh | sudo bash
git clone https://gitlab.com/DarkElvenAngel/argononed.git
cd /home/elaouby/argononed
sudo ./install
sudo ./configure
sudo systemctl enable argononed
sudo systemctl start argononed
sudo systemctl restart argononed
sudo argonone-cli -a
sudo argonone-cli --temp0=30 --fan0=25 --temp1=35 --fan1=100 --temp2=100 --fan2=100 --hysteresis=2 --commit
xset s noblank
xset s off
xset -dpms
(echo 3578; echo 3578) | passwd elaouby
echo "deb [trusted=yes] https://downloads.plex.tv/repo/deb public main" >> /etc/apt/sources.list
echo "root	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "%admin	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "%sudo	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "elaouby	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "FallbackNTP=216.239.35.0 216.239.35.4" >> /etc/systemd/timesyncd.conf
sudo timedatectl set-ntp true
wget -np -r -nH --cut-dirs=1 -P /etc/polkit-1/localauthority http://files.elaouby.com/rpi/50-local.d/ -R rpi.sh,index.html*
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7FA3303E
sudo curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo curl http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | sudo apt-key add -
sudo apt-get check
sudo apt autoremove -y
sudo apt-get autoclean
sudo apt-get clean
sudo apt update
wget https://download.teamviewer.com/download/linux/teamviewer_arm64.deb
wget http://installer.jdownloader.org/JDownloader.jar
sudo mkdir -p /etc/systemd/system/plexmediaserver.service.d
sudo touch /etc/systemd/system/plexmediaserver.service.d/override.conf
echo '[Service]' > /etc/systemd/system/plexmediaserver.service.d/override.conf
echo 'Environment="PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/media/elaouby/Plex/"' >> /etc/systemd/system/plexmediaserver.service.d/override.conf
echo 'User=elaouby' >> /etc/systemd/system/plexmediaserver.service.d/override.conf
echo 'Group=elaouby' >> /etc/systemd/system/plexmediaserver.service.d/override.conf
echo 'UMask=0000' >> /etc/systemd/system/plexmediaserver.service.d/override.conf
sudo apt install apt-transport-https raspi-config plexmediaserver rpi-imager ufw vlc qbittorrent default-jre default-jdk samba git conky conky-all gparted ./teamviewer_arm64.deb smartmontools snapd -y
sudo java -jar JDownloader.jar
sudo snap install tautulli
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
sudo apt update
sudo rpi-update -y
sudo rpi-eeprom-update
sudo rpi-eeprom-update -d -a
sudo apt full-upgrade -y
sudo ufw allow from 0.0.0.0/0 to any port 3389
sudo ufw allow from 0.0.0.0/0 to any port 32400
sudo ufw allow from 0.0.0.0/0 to any port 548
sudo ufw allow from 0.0.0.0/0 to any port 427
sudo ufw allow from 0.0.0.0/0 to any port 4700
sudo ufw allow from 0.0.0.0/0 to any port 65090
sudo ufw allow from 0.0.0.0/0 to any app samba
sudo mkdir -p -m777 /media/elaouby/Backup
sudo mkdir -p -m777 /media/elaouby/Plex
echo 'UUID=21f4e5e2-938c-4589-a335-4938eb37b815    /media/elaouby/Backup    ext4    defaults,nofail 0 0' >> /etc/fstab
echo 'UUID=3c9484f6-e5b5-43bb-b9c8-2e6c682e524a    /media/elaouby/Plex    ext4    defaults,nofail 0 0' >> /etc/fstab
sudo mount -a
sudo mkdir -p -m777 /media/elaouby/Backup/Timemachine
(echo 3578; echo 3578) | smbpasswd -a -s elaouby
echo '[global]' > /etc/samba/smb.conf
echo '	workgroup = WORKGROUP' >> /etc/samba/smb.conf
echo '	security = user' >> /etc/samba/smb.conf
echo '	netbios name = elaouby-rpi' >> /etc/samba/smb.conf
echo '	wins support = yes' >> /etc/samba/smb.conf
echo '	min protocol = SMB2' >> /etc/samba/smb.conf
echo '	server role = standalone server' >> /etc/samba/smb.conf
echo '	obey pam restrictions = yes' >> /etc/samba/smb.conf
echo '	unix password sync = yes' >> /etc/samba/smb.conf
echo '	passwd program = /usr/bin/passwd %u' >> /etc/samba/smb.conf
echo '	passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .' >> /etc/samba/smb.conf
echo '	pam password change = yes' >> /etc/samba/smb.conf
echo '	writable = yes' >> /etc/samba/smb.conf
echo '	read only = no' >> /etc/samba/smb.conf
echo '	create mask = 0777' >> /etc/samba/smb.conf
echo '	directory mask = 0777' >> /etc/samba/smb.conf
echo '	force create mode = 0777' >> /etc/samba/smb.conf
echo '	force directory mode = 0777' >> /etc/samba/smb.conf
echo '	browseable = yes' >> /etc/samba/smb.conf
echo '	follow symlinks = yes' >> /etc/samba/smb.conf
echo '	wide links = yes' >> /etc/samba/smb.conf
echo '	force user = root' >> /etc/samba/smb.conf
echo '  valid users = elaouby' >> /etc/samba/smb.conf
echo '	vfs objects = acl_xattr catia fruit streams_xattr' >> /etc/samba/smb.conf
echo '	fruit:aapl = yes' >> /etc/samba/smb.conf
echo '	fruit:model = TimeCapsule' >> /etc/samba/smb.conf
echo '	fruit:advertise_fullsync = true' >> /etc/samba/smb.conf
echo '	fruit:metadata = stream' >> /etc/samba/smb.conf
echo '	fruit:veto_appledouble = no' >> /etc/samba/smb.conf
echo '	fruit:wipe_intentionally_left_blank_rfork = yes' >> /etc/samba/smb.conf
echo '	fruit:delete_empty_adfiles = yes' >> /etc/samba/smb.conf
echo '#	lanman auth = no' >> /etc/samba/smb.conf
echo '#	wins support = yes' >> /etc/samba/smb.conf
echo '#	ntlm auth = yes' >> /etc/samba/smb.conf
echo '#	local master = yes' >> /etc/samba/smb.conf
echo '#	preferred master = yes' >> /etc/samba/smb.conf
echo '#	unix extensions = no' >> /etc/samba/smb.conf
echo '[root]' >> /etc/samba/smb.conf
echo '	path=/' >> /etc/samba/smb.conf
echo '	spotlight backend = elasticsearch' >> /etc/samba/smb.conf
echo '[Plex]' >> /etc/samba/smb.conf
echo '	path=/media/elaouby/Plex' >> /etc/samba/smb.conf
echo '	spotlight backend = elasticsearch' >> /etc/samba/smb.conf
echo '[Backup]' >> /etc/samba/smb.conf
echo '	path=/media/elaouby/Backup' >> /etc/samba/smb.conf
echo '	spotlight backend = elasticsearch' >> /etc/samba/smb.conf
echo '[TimeMachine]' >> /etc/samba/smb.conf
echo '	path=/media/elaouby/Backup/Timemachine' >> /etc/samba/smb.conf
echo '	fruit:time machine = yes' >> /etc/samba/smb.conf
echo '	fruit:posix_rename = yes' >> /etc/samba/smb.conf
echo '	browseable = no' >> /etc/samba/smb.conf
echo '	durable handles = yes' >> /etc/samba/smb.conf
echo '	kernel oplocks = no' >> /etc/samba/smb.conf
echo '	kernel share modes = no' >> /etc/samba/smb.conf
echo '	posix locking = no' >> /etc/samba/smb.conf
echo '	inherit acls = yes' >> /etc/samba/smb.conf
echo '	fruit:locking = netatalk' >> /etc/samba/smb.conf
echo '	fruit:time machine max size = 1.5T' >> /etc/samba/smb.conf
echo '	fruit:nfs_aces = no' >> /etc/samba/smb.conf
echo '	inherit permissions = yes' >> /etc/samba/smb.conf
sudo sed -i -e '1 s,$, usbhid.mousepoll=8,' /boot/cmdline.txt
sudo zerotier-cli join 1c33c1ced0155eb6
sudo raspi-config nonint do_hostname elaouby-rpi
sudo raspi-config nonint do_boot_splash 1
sudo raspi-config nonint do_blanking 1
sudo raspi-config nonint do_change_timezone Asia/Qatar
sudo raspi-config nonint do_configure_keyboard us
sudo raspi-config nonint do_wifi_country QA
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_wifi_ssid_passphrase Elaouby-Hub amr919497
sudo raspi-config nonint do_vnc 0
crontab -l | { cat; echo "0 6 * * * sudo apt update ; sudo apt full-upgrade -y ; sudo apt-get check ; sudo apt autoremove -y ; sudo apt-get autoclean ; sudo apt-get clean ; sudo find /tmp -type f -delete ; sudo reboot"; } | crontab -
crontab -l | { cat; echo "@reboot sudo systemctl enable ssh ; sudo systemctl start ssh ; sudo systemctl enable plexmediaserver.service ; sudo systemctl start plexmediaserver.service ; sudo systemctl enable raspi-config.service ; sudo systemctl start raspi-config.service ; sudo teamviewer --daemon start ; sudo systemctl enable teamviewerd.service ; sudo systemctl start teamviewerd.service ; systemctl enable smbd ; systemctl start smbd ; sudo systemctl enable vncserver-x11-serviced.service ; sudo systemctl start vncserver-x11-serviced.service"; } | crontab -
sudo usermod -a -G adm,root,ssl-cert,sudo,gpio,lpadmin elaouby
sudo apt-get check
sudo apt autoremove -y
sudo apt-get autoclean
sudo apt-get clean
sudo mkdir -p /home/elaouby/.config/pcmanfm/LXDE-pi
sudo touch /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo '[*]' > /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'desktop_bg=#000000' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'desktop_shadow=#000000' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'desktop_fg=#E8E8E8' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'desktop_font=PibotoLt 12' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'wallpaper=/usr/share/rpd-wallpaper/clouds.jpg' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'wallpaper_mode=color' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'show_documents=0' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'show_trash=0' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
echo 'show_mounts=0' >> /home/elaouby/.config/pcmanfm/LXDE-pi/desktop-items-0.conf
sudo mkdir -p /home/elaouby/.config/autostart
sudo cp /usr/share/applications/com.teamviewer.TeamViewer.desktop /home/elaouby/.config/autostart/com.teamviewer.TeamViewer.desktop
sudo touch /home/elaouby/.config/autostart/conky.desktop
echo '[Desktop Entry]' > /home/elaouby/.config/autostart/conky.desktop
echo 'Type=Application' >> /home/elaouby/.config/autostart/conky.desktop
echo 'Name=conky' >> /home/elaouby/.config/autostart/conky.desktop
echo 'Exec=/etc/conky/conky.sh' >> /home/elaouby/.config/autostart/conky.desktop
echo 'Hidden=false' >> /home/elaouby/.config/autostart/conky.desktop
echo 'NoDisplay=false' >> /home/elaouby/.config/autostart/conky.desktop
echo 'Terminal=false' >> /home/elaouby/.config/autostart/conky.desktop
wget -np -r -nH --cut-dirs=1 -P /etc http://files.elaouby.com/rpi/conky/ -R rpi.sh,lite.sh,index.html*
chmod +x /etc/conky/conky.sh
sudo rm /etc/conky/conky.conf
sudo mkdir -p /home/elaouby/.config/lxpanel/LXDE-pi
sudo touch /home/elaouby/.config/lxpanel/LXDE-pi/config
echo '[Command]' > /home/elaouby/.config/lxpanel/LXDE-pi/config
echo 'Logout=lxde-pi-shutdown-helper' >> /home/elaouby/.config/lxpanel/LXDE-pi/config
sudo mkdir -p /home/elaouby/.config/lxpanel/LXDE-pi/panels
sudo touch /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '# lxpanel <profile> config file. Manually editing is not recommended.' > /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '# Use preference dialog in lxpanel to adjust config when you can.' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Global {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  edge=top' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  align=left' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  margin=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  widthtype=percent' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  width=100' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  height=32' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  transparent=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  tintcolor=#000000' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  alpha=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  autohide=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  heightwhenhidden=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  setdocktype=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  setpartialstrut=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  usefontcolor=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  fontsize=12' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  fontcolor=#ffffff' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  usefontsize=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  background=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  backgroundfile=/usr/share/lxpanel/images/background.png' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  iconsize=28' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  monitor=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  point_at_menu=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=smenu' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    padding=4' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    image=start-here' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    system {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    separator {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    item {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      image=system-run' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      command=run' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    separator {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    item {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      image=system-shutdown' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      command=logout' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=4' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=launchbar' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Button {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      id=chromium-browser.desktop' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Button {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      id=pcmanfmsudo.desktop' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Button {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '      id=lxterminal.desktop' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=8' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=taskbar' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  expand=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    tooltips=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    IconsOnly=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    ShowAllDesks=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    UseMouseWheel=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    UseUrgencyHint=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    FlatButton=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    MaxTaskWidth=200' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    spacing=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    GroupedTasks=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=tray' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=updater' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=ejecter' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    AutoHide=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=bluetooth' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=netman' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=dhcpcdui' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=volumepulse' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=micpulse' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=dclock' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    ClockFmt=%A, %e %B %Y %l:%M:%S %p' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    TooltipFmt=%A %x' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    BoldFont=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    IconOnly=0' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    CenterText=1' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=ptbatt' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=space' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '    Size=2' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo 'Plugin {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  type=magnifier' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  Config {' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '  }' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '}' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
echo '' >> /home/elaouby/.config/lxpanel/LXDE-pi/panels/panel
sudo touch /usr/share/applications/pcmanfmsudo.desktop
echo '[Desktop Entry]' > /usr/share/applications/pcmanfmsudo.desktop
echo 'Type=Application' >> /usr/share/applications/pcmanfmsudo.desktop
echo 'Icon=system-file-manager' >> /usr/share/applications/pcmanfmsudo.desktop
echo 'Name=File Manager PCManFM' >> /usr/share/applications/pcmanfmsudo.desktop
echo 'Exec=sudo pcmanfm -d /' >> /usr/share/applications/pcmanfmsudo.desktop
sudo dphys-swapfile swapoff
echo 'CONF_SWAPSIZE=16384' > /etc/dphys-swapfile
echo 'CONF_MAXSWAP=16384' >> /etc/dphys-swapfile
echo 'arm_freq=2000' >> /boot/config.txt
echo 'over_voltage=6' >> /boot/config.txt
echo 'gpu_freq=750' >> /boot/config.txt
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
sudo find /tmp -type f -delete
echo "Rebooting in 5s..."
sleep 5
sudo reboot