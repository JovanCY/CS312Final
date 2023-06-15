#!/bin/bash

#created with the help of ChatGPT

exec > >(tee /var/log/userdata.log|logger -t userdata -s 2>/dev/console) 2>&1

# Update the system and install required packages
sudo yum update -y
sudo yum install -y amazon-linux-extras

# Enable the EPEL repository
sudo amazon-linux-extras enable epel

# Install Docker
sudo yum install -y docker

# Start the Docker service
sudo service docker start

# Enable Docker service to start on system boot
sudo chkconfig docker on

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Pull the Minecraft server image
sudo docker pull itzg/minecraft-server:java17-alpine

# Create a directory for Minecraft server data
mkdir minecraft-data

# Create the Docker Compose file
tee docker-compose.yml << EOT
version: "3"
services:
  mc:
    container_name: minecraft-server
    image: itzg/minecraft-server:java17-alpine
    ports:
      - 25565:25565
    environment:
      EULA: "TRUE"
    tty: true
    stdin_open: true
    restart: unless-stopped
    volumes:
      - ./minecraft-data:/data
EOT

# Start the Minecraft server using Docker Compose
sudo /usr/local/bin/docker-compose -p minecraft up -d
