import csv
import re

def sanitize_hostname(description):
	# Replace spaces and special characters with underscores
	sanitized = re.sub(r'[^a-zA-Z0-9]', '_', description)
	sanitized = re.sub(r'_+', '_', sanitized)
	sanitized = sanitized.rstrip('_')
	return sanitized

def generate_dhcpd_conf(csv_file, output_file):
	with open(csv_file, 'r') as file:
		reader = csv.DictReader(file, delimiter=';')
		fixed_addresses = [
			f"""host {sanitize_hostname(row['Description'])} {{
  hardware ethernet {row['MAC Address']};
  fixed-address {row['IP Address']};
}}"""
			for row in reader
		]

	config = f"""
# DHCP Server Configuration file

option domain-name "local";
option domain-name-servers 192.168.1.1;

default-lease-time 600;
max-lease-time 7200;

# Use this to enable / disable dynamic DNS updates globally.
ddns-update-style none;

# Configuration for the Docker subnet (e.g., 192.168.65.0/24)
subnet 192.168.65.0 netmask 255.255.255.0 {{
	range 192.168.65.150 192.168.65.254;
	option routers 192.168.65.1;
	option subnet-mask 255.255.255.0;
	option broadcast-address 192.168.65.255;
	option domain-name-servers 8.8.8.8, 8.8.4.4;
}}

# Configuration for the 192.168.1.0/24 subnet
subnet 192.168.1.0 netmask 255.255.255.0 {{
	authoritative;
	range 192.168.1.150 192.168.1.254;
	option routers 192.168.1.1;
	option subnet-mask 255.255.255.0;
	option broadcast-address 192.168.1.255;
	option domain-name-servers 192.168.1.1, 8.8.8.8;
}}

{'\n'.join(fixed_addresses)}
"""

	with open(output_file, 'w') as file:
		file.write(config)

# Usage
generate_dhcpd_conf('devices.csv', 'dhcpd.conf')
