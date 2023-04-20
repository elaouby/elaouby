# model = RBD53iG-5HacD2HnD
# serial number = F34E0F44E339
/ip dhcp-client add interface=ether1
:delay 5s
/system leds settings set all-leds-off=immediate
/system routerboard reset-button set enabled=yes hold-time=0s..1s on-event=":execute {/system reset-configuration keep-users=no no-defaults=yes skip-backup=yes run-after-reset=usb1-part1/Config/config.rsc}"
/file remove [find type=".txt file"]
/ip neighbor discovery-settings set discover-interface-list=all
/interface ethernet set [ find default-name=ether1 ] name=ether1-POE-in
/interface ethernet set [ find default-name=ether5 ] name=ether5-POE-out
/interface wifiwave2 set [ find default-name=wifi1 ] channel.band=2ghz-n .width=20/40mhz configuration.mode=ap .ssid=MikroTik disabled=no security.authentication-types=wpa2-psk,wpa3-psk .passphrase=xxxx
/interface wifiwave2 set [ find default-name=wifi2 ] channel.band=5ghz-ac .frequency=5180 .width=20/40/80mhz configuration.mode=ap .ssid=MikroTik disabled=no security.authentication-types=wpa2-psk,wpa3-psk .passphrase=xxxx
/interface wifiwave2 add configuration.mode=ap .ssid=VPN disabled=no master-interface=wifi1 name=wifi3 security.authentication-types=wpa2-psk,wpa3-psk .passphrase=xxxx channel.band=2ghz-n .width=20mhz mac-address=DE:2C:6E:14:AF:B9
/interface wifiwave2 add configuration.mode=ap .ssid=VPN disabled=no master-interface=wifi2 name=wifi4 security.authentication-types=wpa2-psk,wpa3-psk .passphrase=xxxx channel.band=5ghz-ac .width=20mhz .frequency=5180 mac-address=DE:2C:6E:14:AF:C0
/interface wifiwave2 add configuration.mode=ap .ssid=Guest disabled=no master-interface=wifi1 name=wifi5 channel.band=2ghz-n .width=20mhz mac-address=DE:2C:6E:14:AF:C1
/interface bridge add admin-mac=DC:2C:6E:14:AF:B3 auto-mac=no name=bridge
/interface bridge add admin-mac=DC:2C:6E:14:AF:B9 auto-mac=no name=vpn
/interface bridge add admin-mac=DC:2C:6E:14:AF:C1 auto-mac=no name=guest
/interface bridge port add bridge=bridge ingress-filtering=no interface=ether2
/interface bridge port add bridge=bridge ingress-filtering=no interface=ether3
/interface bridge port add bridge=bridge ingress-filtering=no interface=ether4
/interface bridge port add bridge=bridge ingress-filtering=no interface=ether5-POE-out
/interface bridge port add bridge=bridge ingress-filtering=no interface=wifi1
/interface bridge port add bridge=bridge ingress-filtering=no interface=wifi2
/interface bridge port add bridge=vpn ingress-filtering=no interface=wifi3
/interface bridge port add bridge=vpn ingress-filtering=no interface=wifi4
/interface bridge port add bridge=guest ingress-filtering=no interface=wifi5
/interface list add name=WAN
/interface list add name=LAN
/interface list add name=VPN
/interface list add name=GUEST
/interface list member add interface=bridge list=LAN
/interface list member add interface=ether1-POE-in list=WAN
/interface list member add interface=vpn list=VPN
/interface list member add interface=guest list=GUEST
/ip address add address=10.10.0.1/20 interface=bridge network=10.10.0.0
/ip address add address=10.10.16.1/24 interface=vpn network=10.10.16.0
/ip address add address=10.10.17.1/24 interface=guest network=10.10.17.0
/ip pool add name=dhcp ranges=10.10.0.100-10.10.15.254
/ip pool add name=vpn ranges=10.10.16.2-10.10.16.254
/ip pool add name=guest ranges=10.10.17.2-10.10.17.254
/ip dhcp-server add address-pool=dhcp interface=bridge name=dhcp
/ip dhcp-server add address-pool=vpn interface=vpn name=vpn
/ip dhcp-server add address-pool=guest interface=guest name=guest
/ip dhcp-server network add address=10.10.0.0/20 dns-server=8.8.8.8,8.8.4.4 gateway=10.10.0.1
/ip dhcp-server network add address=10.10.16.0/24 gateway=10.10.16.1
/ip dhcp-server network add address=10.10.17.0/24 dns-server=8.8.8.8,8.8.4.4 gateway=10.10.17.1
/ip dns set allow-remote-requests=yes
/ip dns static add address=10.0.0.1 name=router.lan
/tool mac-server set allowed-interface-list=all
/tool mac-server mac-winbox set allowed-interface-list=all
/system logging action add disk-file-name=usb1-part1/log/log-critical disk-lines-per-file=65535 name=critical target=disk
/system logging action add disk-file-name=usb1-part1/log/log-debug disk-lines-per-file=65535 name=debug target=disk
/system logging action add disk-file-name=usb1-part1/log/log-error disk-lines-per-file=65535 name=error target=disk
/system logging action add disk-file-name=usb1-part1/log/log-info disk-lines-per-file=65535 name=info target=disk
/system logging action add disk-file-name=usb1-part1/log/log-ipsec disk-lines-per-file=65535 name=ipsec target=disk
/system logging action add disk-file-name=usb1-part1/log/log-system disk-lines-per-file=65535 name=system target=disk
/system logging action add disk-file-name=usb1-part1/log/log-warning disk-lines-per-file=65535 name=warning target=disk
/system logging action add disk-file-name=usb1-part1/log/log-wireguard disk-lines-per-file=65535 name=wireguard target=disk
/system logging add action=critical topics=critical
/system logging add action=debug topics=debug,!packet
/system logging add action=error topics=error
/system logging add action=info topics=info
/system logging add action=ipsec topics=ipsec,!packet
/system logging add action=system topics=system
/system logging add action=warning topics=warning
/system logging add action=wireguard topics=wireguard
/ip firewall address-list add address=10.10.0.0/20 list=dhcp
/ip firewall address-list add address=10.10.16.0/24 list=vpn
/ip firewall address-list add address=10.10.17.0/24 list=guest
/ip firewall filter add chain=input dst-port=22,8291 protocol=tcp comment="Enable MikroTik Ports"
/ip firewall filter add action=drop chain=forward dst-address=10.10.0.2-10.10.15.254 src-address=10.10.16.2-10.10.16.254 comment="Block VPN to Normal Hosts"
/ip firewall filter add action=drop chain=forward dst-address=10.10.17.2-10.10.17.254 src-address=10.10.16.2-10.10.16.254 comment="Block VPN to Guest Hosts"
/ip firewall filter add action=drop chain=forward dst-address=10.10.16.2-10.10.16.254 src-address=10.10.0.2-10.10.15.254 comment="Block Normal to VPN Hosts"
/ip firewall filter add action=drop chain=forward dst-address=10.10.17.2-10.10.17.254 src-address=10.10.0.2-10.10.15.254 comment="Block Normal to Guest Hosts"
/ip firewall filter add action=drop chain=forward dst-address=10.10.0.2-10.10.15.254 src-address=10.10.17.2-10.10.17.254 comment="Block Guest to Normal Hosts"
/ip firewall filter add action=drop chain=forward dst-address=10.10.16.2-10.10.16.254 src-address=10.10.17.2-10.10.17.254 comment="Block Guest to VPN Hosts"
/ip firewall filter add action=drop chain=input dst-address=10.10.0.2-10.10.15.254 src-address=10.10.16.2-10.10.16.254 comment="Block VPN to Normal Gateway"
/ip firewall filter add action=drop chain=input dst-address=10.10.17.2-10.10.17.254 src-address=10.10.16.2-10.10.16.254 comment="Block VPN to Guest Gateway"
/ip firewall filter add action=drop chain=input dst-address=10.10.16.2-10.10.16.254 src-address=10.10.0.2-10.10.15.254 comment="Block Normal to VPN Gateway"
/ip firewall filter add action=drop chain=input dst-address=10.10.17.2-10.10.17.254 src-address=10.10.0.2-10.10.15.254 comment="Block Normal to Guest Gateway"
/ip firewall filter add action=drop chain=input dst-address=10.10.16.2-10.10.16.254 src-address=10.10.17.2-10.10.17.254 comment="Block Guest to VPN Gateway"
/ip firewall filter add action=drop chain=input dst-address=10.10.0.2-10.10.15.254 src-address=10.10.17.2-10.10.17.254 comment="Block Guest to Normal Gateway"
/ip firewall filter add action=accept chain=input comment="Accept Input established,related,untracked" connection-state=established,related,untracked
/ip firewall filter add action=drop chain=input comment="Drop Input drop invalid" connection-state=invalid
/ip firewall filter add action=accept chain=input comment="Accept Input ICMP" protocol=icmp
/ip firewall filter add action=accept chain=input comment="Accept Input All Interfaces" in-interface-list=all
/ip firewall filter add action=accept chain=forward ipsec-policy=in,ipsec comment="Accept Forward IPSec In"
/ip firewall filter add action=accept chain=forward ipsec-policy=out,ipsec comment="Accept Forward IPSec Out"
/ip firewall filter add action=accept chain=forward comment="Accept Forward Guest Upload Skip" connection-state=established,related src-address-list=guest
/ip firewall filter add action=accept chain=forward comment="Accept Forward Guest Download Skip" connection-state=established,related dst-address-list=guest
/ip firewall filter add action=fasttrack-connection chain=forward comment="Fasttrack" connection-state=established,related connection-mark=no-mark
/ip firewall filter add action=accept chain=forward comment="Accept Forward established, related & untracked" connection-state=established,related,untracked
/ip firewall filter add action=accept chain=input comment="Allow IPSEC/IKE2 Protocol UDP" dst-port=500,4500 protocol=udp
/ip firewall filter add action=accept chain=input comment="Allow IPSEC/IKE2 Protocol ESP" protocol=ipsec-esp
/ip firewall filter add action=drop chain=forward comment="Drop Forward drop invalid" connection-state=invalid
/ip firewall filter add action=drop chain=forward comment="Drop incoming packets that are not NAT`ted" connection-nat-state=!dstnat connection-state=new in-interface-list=WAN log=yes log-prefix=!NAT
/ip firewall filter add action=accept chain=forward comment="Allow Traffic LAN" in-interface-list=LAN out-interface-list=WAN
/ip firewall filter add action=accept chain=forward comment="Allow Traffic VPN" in-interface-list=VPN out-interface-list=WAN
/ip firewall filter add action=accept chain=forward comment="Allow Port Forwarding" connection-nat-state=dstnat
/ip firewall filter add action=drop chain=forward comment="Isolate VPN to VPN" dst-address=10.10.16.2-10.10.16.254 src-address=10.10.16.2-10.10.16.254
/ip firewall filter add action=drop chain=forward comment="Isolate VPN to LAN" dst-address=10.10.0.2-10.10.15.254 src-address=10.10.16.2-10.10.16.254
/ip firewall filter add action=drop chain=forward comment="Isolate VPN to GUEST" dst-address=10.10.17.2-10.10.17.254 src-address=10.10.16.2-10.10.16.254
/ip firewall filter add action=drop chain=forward comment="Isolate GUEST to GUEST" dst-address=10.10.17.2-10.10.17.254 src-address=10.10.17.2-10.10.17.254
/ip firewall filter add action=drop chain=forward comment="Isolate GUEST to LAN" dst-address=10.10.0.2-10.10.15.254 src-address=10.10.17.2-10.10.17.254
/ip firewall filter add action=drop chain=forward comment="Isolate GUEST to VPN" dst-address=10.10.0.2-10.10.15.254 src-address=10.10.17.2-10.10.17.254
/ip firewall mangle add action=mark-packet chain=forward comment="Guest Mark Upload" new-packet-mark=Guest-Upload passthrough=yes src-address-list=guest
/ip firewall mangle add action=mark-packet chain=forward comment="Guest Mark Download" dst-address-list=guest new-packet-mark=Guest-Download passthrough=yes
/ip firewall nat add action=redirect chain=dstnat dst-port=80 protocol=tcp src-address=10.10.0.0/19 to-ports=8080 comment="Blocking Websites"
/ip firewall nat add action=masquerade chain=srcnat out-interface-list=WAN comment="Masquerade"
/ip firewall nat add action=dst-nat chain=dstnat dst-port=32400 in-interface=ether1-POE-in protocol=tcp to-addresses=10.10.0.10 to-ports=32400
/ip firewall nat add action=dst-nat chain=dstnat dst-port=51596 in-interface=ether1-POE-in protocol=tcp to-addresses=10.10.0.0/22 to-ports=51596
/queue tree add name=Total parent=global
/queue tree add max-limit=256k name=Guest-Download packet-mark=Guest-Download parent=Total
/queue tree add max-limit=256k name="Guest Upload" packet-mark=Guest-Upload parent=Total
/ip proxy set cache-administrator=amr@elaouby.com enabled=yes
/ip proxy access add action=deny disabled=no dst-host=test.test.test
/ip upnp set enabled=yes show-dummy-rule=no
/ip upnp interfaces add interface=ether1-POE-in type=external
/ip upnp interfaces add interface=bridge type=internal
/ip upnp interfaces add interface=vpn type=internal
/system ntp client set enabled=yes
/system ntp client servers add address=216.239.35.0
/system ntp client servers add address=216.239.35.4
/certificate import file-name="usb1-part1/VPN/nordvpn.der" name=NordVPN passphrase=""
/certificate import file-name="usb1-part1/VPN/protonvpn.der" name=ProtonVPN passphrase=""
/ip ipsec profile add name="NordVPN"
/ip ipsec profile add dh-group=modp4096,modp2048,modp1024 dpd-interval=disable-dpd enc-algorithm=aes-256 hash-algorithm=sha256 name="ProtonVPN"
/ip ipsec proposal add name="NordVPN" pfs-group=none
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc lifetime=0s name="ProtonVPN" pfs-group=none
/ip ipsec policy group add name="NordVPN"
/ip ipsec policy group add name=æProtonVPN"
/ip ipsec policy add dst-address=0.0.0.0/0 group="NordVPN" proposal="NordVPN" src-address=0.0.0.0/0 template=yes
/ip ipsec policy add dst-address=0.0.0.0/0 group="ProtonVPN" proposal="ProtonVPN" src-address=0.0.0.0/0 template=yes
/ip ipsec mode-config add name="NordVPN" responder=no src-address-list=vpn
/ip ipsec mode-config add connection-mark=vpn name="ProtonVPN" responder=no src-address-list=vpn
/ip ipsec peer add address=ch412.nordvpn.com exchange-mode=ike2 name="NordVPN" profile="NordVPN"
/ip ipsec peer add address=nl-free-112.protonvpn.net exchange-mode=ike2 name="ProtonVPN" profile="ProtonVPN"
/ip ipsec identity add auth-method=eap certificate="NordVPN" eap-methods=eap-mschapv2 generate-policy=port-strict mode-config="NordVPN" peer="NordVPN" policy-template-group="NordVPN" username=xxxx password=xxxx
/ip ipsec identity add auth-method=eap certificate="ProtonVPN" eap-methods=eap-mschapv2 generate-policy=port-strict mode-config="ProtonVPN" peer="ProtonVPN" policy-template-group="ProtonVPN" username=xxxx password=xxxx
/user add name=elaouby group=full password=Ae29181801274!
/user remove admin
/system scheduler add interval=1d name=Reboot on-event="/system reboot" policy=reboot start-date=jan/01/1970 start-time=06:00:00
/system identity set name=MikroTik-hAP-ac^3
/system logging action set memory memory-lines=1
/system logging action set memory memory-lines=1000
/system leds settings set all-leds-off=never
/console clear-history
:execute {/system reboot;}