#!/bin/sh

# Stop and Remove Containers:
docker-compose down
docker-compose rm -f
docker container prune -f

# Prune unused networks
docker network prune -f

# Rebuild and start containers
docker-compose build
docker-compose up -d
