#! /bin/bash

sleep 15 ;
sudo argonone-cli -a ;
sudo argonone-cli --temp0=30 --fan0=25 --temp1=35 --fan1=100 --temp2=100 --fan2=100 --hysteresis=2 --commit ;
sudo qbittorrent --no-splash &
conky -p 5 -c /etc/conky/conky-tm-clock.conf &
conky -p 6 -c /etc/conky/conky-bm-networking.conf &
conky -p 7 -c /etc/conky/conky-bml-wired.conf &
conky -p 8 -c /etc/conky/conky-bmr-wireless.conf &
conky -p 9 -c /etc/conky/conky-tl-hdd.conf &
conky -p 10 -c /etc/conky/conky-tr-sys.conf &
conky -p 11 -c /etc/conky/conky-bl-proc_cpu.conf &
conky -p 12 -c /etc/conky/conky-br-proc_mem.conf &
conky -p 13 -c /etc/conky/conky-mm-warning.conf &
sudo rm /home/elaouby/JDownloader.jar
wget /home/elaouby http://installer.jdownloader.org/JDownloader.jar
sudo java -jar /home/elaouby/JDownloader.jar -norestart -m