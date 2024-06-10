docker stop dhcp-server
docker run -d --name dhcp-server --cap-add=NET_ADMIN --network bridge -p 192.168.1.70:67:67 -p 192.168.1.70:68:68 -e "INTERFACE=en0" dhcp-server
# docker run -d --name dhcp-server --cap-add=NET_ADMIN --net=host dhcp-server