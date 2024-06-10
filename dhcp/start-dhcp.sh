#!/bin/sh

# Set up iptables rules to forward DHCP traffic
iptables -A FORWARD -i eth0 -o eth0 -p udp --dport 67:68 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth0 -p udp --sport 67:68 -j ACCEPT
iptables -t nat -A POSTROUTING -s 172.18.0.0/24 ! -d 172.18.0.0/24 -j MASQUERADE

# Ensure lease file exists and is writable
mkdir -p /var/lib/dhcp
touch /var/lib/dhcp/dhcpd.leases
chmod 666 /var/lib/dhcp/dhcpd.leases

# Start the DHCPv4 server
dhcpd -4 -f -d -cf /etc/dhcp/dhcpd.conf eth0