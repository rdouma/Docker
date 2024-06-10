# Use the official Ubuntu base image
FROM ubuntu:latest

# Update and install necessary packages
RUN apt-get update && apt-get install -y isc-dhcp-server iputils-ping iproute2 net-tools dnsutils tcpdump iptables

# Create necessary directories and files for DHCPv4
RUN mkdir -p /var/lib/dhcp && touch /var/lib/dhcp/dhcpd.leases

# Copy the dhcpd.conf file to the container
COPY dhcpd.conf /etc/dhcp/dhcpd.conf

# Copy the startup script to the container
COPY start-dhcp.sh /usr/local/bin/start-dhcp.sh
RUN chmod +x /usr/local/bin/start-dhcp.sh

# Expose the necessary ports for DHCPv4
EXPOSE 67/udp 68/udp

# Set the default command to run the startup script
CMD ["/usr/local/bin/start-dhcp.sh"]
