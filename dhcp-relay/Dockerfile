# Dockerfile for dhcp-helper
FROM debian:latest

RUN apt-get update && apt-get install -y isc-dhcp-relay iproute2 iputils-ping tcpdump

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
