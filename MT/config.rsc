/file remove [find type=directory]
/ip smb shares add name=Backup directory=Backup
/ip smb shares add name=log directory=log
/ip smb shares add name=VPN directory=VPN
/tool fetch url="https://github.com/elaouby/elaouby.github.io/blob/main/MT/nordvpn.der" dst-path=VPN/nordvpn.der
/tool fetch url="https://github.com/elaouby/elaouby.github.io/blob/main/MT/protonvpn.der" dst-path=VPN/protonvpn.der
/tool fetch url="https://github.com/elaouby/elaouby.github.io/blob/main/MT/config.rsc" dst-path=Backup/config.rsc
/tool fetch url="https://github.com/elaouby/elaouby.github.io/blob/main/MT/dhcp-client.rsc" dst-path=Backup/dhcp-client.rsc
/system logging action
add disk-file-name=log/log-critical disk-lines-per-file=65535 name=critical target=disk
add disk-file-name=log/log-debug disk-lines-per-file=65535 name=debug target=disk
add disk-file-name=log/log-error disk-lines-per-file=65535 name=error target=disk
add disk-file-name=log/log-info disk-lines-per-file=65535 name=info target=disk
add disk-file-name=log/log-ipsec disk-lines-per-file=65535 name=ipsec target=disk
add disk-file-name=log/log-system disk-lines-per-file=65535 name=system target=disk
add disk-file-name=log/log-warning disk-lines-per-file=65535 name=warning target=disk
add disk-file-name=log/log-wireguard disk-lines-per-file=65535 name=wireguard target=disk
/system logging
add action=critical topics=critical
add action=debug topics=debug,!packet
add action=error topics=error
add action=info topics=info
add action=ipsec topics=ipsec,!packet
add action=system topics=system
add action=warning topics=warning
add action=wireguard topics=wireguard
add action=echo topics=wireguard
/user add name=elaouby group=full password=Ae29181801274!
/user remove admin
/interface bridge
add admin-mac=DC:2C:6E:14:AF:B3 auto-mac=no name=bridge
add admin-mac=DC:2C:6E:14:AF:B7 auto-mac=no name=vpn
/interface ethernet
set [ find default-name=ether1 ] name=ether1-POE-in
set [ find default-name=ether5 ] name=ether5-POE-out
/ip dhcp-client
add interface=ether1-POE-in
/interface wifiwave2
set [ find default-name=wifi1 ] channel.band=2ghz-n .width=20/40mhz configuration.mode=ap .ssid=MikroTik disabled=no security.authentication-types=wpa2-psk,wpa3-psk .passphrase=amr919497
set [ find default-name=wifi2 ] channel.band=5ghz-ac .frequency=5220 .width=20/40/80mhz configuration.mode=ap .ssid=MikroTik disabled=no security.authentication-types=wpa2-psk,wpa3-psk .passphrase=amr919497
add configuration.mode=ap .ssid=VPN disabled=no mac-address=DE:2C:6E:14:AF:B7 master-interface=wifi1 name=wifi3 security.authentication-types=wpa2-psk,wpa3-psk .passphrase=amr919497
add configuration.mode=ap .ssid=VPN disabled=no mac-address=DE:2C:6E:14:AF:B8 master-interface=wifi2 name=wifi4 security.authentication-types=wpa2-psk,wpa3-psk .passphrase=amr919497
/interface list
add name=WAN
add name=LAN
add name=VPN
/ip pool
add name=dhcp ranges=10.10.0.100-10.10.15.254
add name=vpn ranges=10.10.16.2-10.10.16.254
/ip dhcp-server
add address-pool=dhcp interface=bridge name=dhcp
add address-pool=vpn interface=vpn name=vpn
/interface bridge port
add bridge=bridge ingress-filtering=no interface=ether2
add bridge=bridge ingress-filtering=no interface=ether3
add bridge=bridge ingress-filtering=no interface=ether4
add bridge=bridge ingress-filtering=no interface=ether5-POE-out
add bridge=bridge ingress-filtering=no interface=wifi1
add bridge=bridge ingress-filtering=no interface=wifi2
add bridge=vpn ingress-filtering=no interface=wifi3
add bridge=vpn ingress-filtering=no interface=wifi4
/interface list member
add interface=bridge list=LAN
add interface=ether1-POE-in list=WAN
add interface=vpn list=VPN
/ip address
add address=10.10.0.1/20 interface=bridge network=10.10.0.0
add address=10.10.16.1/24 interface=vpn network=10.10.16.0
/ip dhcp-server network
add address=10.10.0.0/20 dns-server=8.8.8.8,8.8.4.4 gateway=10.10.0.1
add address=10.10.16.0/24 gateway=10.10.16.1
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=10.0.0.1 name=router.lan
/ip firewall address-list
add address=10.10.0.0/20 list=dhcp
add address=10.10.16.0/24 list=vpn
/ip firewall filter
add chain=input dst-port=22,8291 protocol=tcp comment="Enable MikroTik Ports"
add action=drop chain=forward dst-address=10.10.0.2-10.10.15.254 src-address=10.10.16.2-10.10.16.254 comment="Block VPN to Normal Hosts"
add action=drop chain=input dst-address=10.10.0.2-10.10.15.254 src-address=10.10.16.2-10.10.16.254 comment="Block VPN to Normal Gateway"
add action=drop chain=forward dst-address=10.10.16.2-10.10.16.254 src-address=10.10.0.2-10.10.15.254 comment="Block Normal to VPN Hosts"
add action=drop chain=input dst-address=10.10.16.2-10.10.16.254 src-address=10.10.0.2-10.10.15.254 comment="Block Normal to VPN Gateway"
add action=accept chain=input comment="Accept Input established,related,untracked" connection-state=established,related,untracked
add action=drop chain=input comment="Drop Input drop invalid" connection-state=invalid
add action=accept chain=input comment="Accept Input ICMP" protocol=icmp
add action=accept chain=input comment="Accept Input All Interaces" in-interface-list=all
add action=fasttrack-connection chain=forward comment="Fasttrack" connection-state=established,related connection-mark=no-mark
add action=accept chain=forward comment="Accept Forward established, related & untracked" connection-state=established,related,untracked
add action=drop chain=forward comment="Drop Forward drop invalid" connection-state=invalid
add action=drop chain=forward comment="Drop incoming packets that are not NAT`ted" connection-nat-state=!dstnat connection-state=new in-interface-list=WAN log=yes log-prefix=!NAT
add action=accept chain=forward comment="Allow Traffic LAN" in-interface-list=LAN out-interface-list=WAN
add action=accept chain=forward comment="Allow Traffic VPN" in-interface-list=VPN out-interface-list=WAN
add action=accept chain=forward comment="Allow Port Forwarding" connection-nat-state=dstnat
add action=drop chain=forward comment="Isolate VPN to VPN" dst-address=10.10.16.2-10.10.16.254 src-address=10.10.16.2-10.10.16.254
add action=drop chain=forward comment="Isolate VPN to LAN" dst-address=10.10.0.2-10.10.15.254 src-address=10.10.16.2-10.10.16.254
add action=accept chain=forward ipsec-policy=in,ipsec comment="Accept Forward IPSec In"
add action=accept chain=forward ipsec-policy=out,ipsec comment="Accept Forward IPSec Out"
/ip firewall mangle
add action=mark-connection chain=prerouting new-connection-mark=vpn passthrough=yes src-address-list=vpn
add action=change-mss chain=forward new-mss=clamp-to-pmtu passthrough=yes protocol=tcp tcp-flags=syn
add action=change-mss chain=forward connection-mark=vpn new-mss=1360 passthrough=yes protocol=tcp tcp-flags=syn
/ip firewall nat
add action=redirect chain=dstnat dst-port=80 protocol=tcp src-address=10.10.0.0/19 to-ports=8080 comment="Blocking Websites"
add action=masquerade chain=srcnat out-interface-list=WAN comment="Masquerade"
add action=dst-nat chain=dstnat dst-port=32400 in-interface=ether1-POE-in protocol=tcp to-addresses=10.10.0.10 to-ports=32400
add action=dst-nat chain=dstnat dst-port=51596 in-interface=ether1-POE-in protocol=tcp to-addresses=10.10.0.0/22 to-ports=51596
/ip proxy set cache-administrator=amr@elaouby.com enabled=yes
/ip proxy access add action=deny disabled=no dst-host=test.test.test
/ip upnp
set enabled=yes show-dummy-rule=no
/ip upnp interfaces
add interface=ether1-POE-in type=external
add interface=bridge type=internal
/system ntp client
set enabled=yes
/system ntp client servers
add address=216.239.35.0
add address=216.239.35.4
/ip ipsec mode-config
add name=NordVPN responder=no src-address-list=vpn
add connection-mark=vpn name=ProtonVPN responder=no src-address-list=vpn
/ip ipsec policy group
add name=NordVPN
add name=ProtonVPN
/ip ipsec profile
add name=NordVPN
add dh-group=modp4096,modp2048,modp1024 dpd-interval=disable-dpd enc-algorithm=aes-256 hash-algorithm=sha256 name=ProtonVPN
/ip ipsec peer
add address=ch412.nordvpn.com exchange-mode=ike2 name=NordVPN profile=NordVPN
add address=nl-free-112.protonvpn.net exchange-mode=ike2 name=ProtonVPN profile=ProtonVPN
/ip ipsec proposal
add name=NordVPN pfs-group=none
add auth-algorithms=sha256 enc-algorithms=aes-256-cbc lifetime=0s name=ProtonVPN pfs-group=none
/ip ipsec policy
add dst-address=0.0.0.0/0 group=NordVPN proposal=NordVPN src-address=0.0.0.0/0 template=yes
add dst-address=0.0.0.0/0 group=ProtonVPN proposal=ProtonVPN src-address=0.0.0.0/0 template=yes
/certificate
import file-name=nordvpn.der name=NordVPN passphrase=""
import file-name=protonvpn.der name=ProtonVPN passphrase=""
/ip ipsec identity
add auth-method=eap certificate=NordVPN eap-methods=eap-mschapv2 generate-policy=port-strict mode-config=NordVPN password=m7EqdtPByupqx1VxPyEWwo3X peer=NordVPN policy-template-group=NordVPN username=tvqMj9NaW46QPQ1TcQf1uJAc
add auth-method=eap certificate=ProtonVPN eap-methods=eap-mschapv2 generate-policy=port-strict mode-config=ProtonVPN password=EVbdD8Szbzohl12vsUzmzmck693l2Ay5 peer=ProtonVPN policy-template-group=ProtonVPN username=50pJAW0nWDAQ33OO