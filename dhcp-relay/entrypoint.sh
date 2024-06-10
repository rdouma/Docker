#!/bin/sh

# Ensure that the correct parameters are passed to dhcrelay
exec dhcrelay -d -i eth0 172.18.0.8