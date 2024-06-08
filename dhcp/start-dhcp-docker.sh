docker stop dhcp-server
docker run -d --network avalon_ipv6 --cap-add=NET_ADMIN --cap-add=NET_RAW --name dhcp-server --privileged oberon-dhcp
