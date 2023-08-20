#!/bin/bash

# Update system 

sudo apt update && sudo apt upgrade -y

# Install Docker 
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose

# Set environment variables
export DOCKER_HOST=unix:///var/run/docker.sock

# Create Docker network
docker network create portainer_agent_network

# Launch Portainer
docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Function to get IP address 
get_ip() {
  ip=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
  echo $ip
}

ip=$(get_ip)

echo "Portainer launched on http://$ip:9000"
