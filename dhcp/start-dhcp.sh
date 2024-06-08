#!/bin/sh

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Set up iptables rules to forward DHCP traffic
iptables -A FORWARD -i eth0 -o docker0 -p udp --dport 67:68 -j ACCEPT
iptables -A FORWARD -i docker0 -o eth0 -p udp --sport 67:68 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.10.0/24 ! -d 192.168.10.0/24 -j MASQUERADE

# Start the DHCPv4 server
dhcpd -4 -f -d -cf /etc/dhcp/dhcpd.conf eth0 &

# Start the DHCPv6 server
dhcpd -6 -f -d -cf /etc/dhcp/dhcpd6.conf eth0
