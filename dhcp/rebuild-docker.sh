docker stop dhcp-server
docker rm dhcp-server
docker rmi oberon-dhcp
docker build -t oberon-dhcp .