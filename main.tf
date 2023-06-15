# Specify your provider (AWS)
provider "aws" {
  region = "us-west-2" # Update with your desired region
}

# Provision EC2 instance
resource "aws_instance" "minecraft_server" {
  ami           = "ami-076bca9dd71a9a578" # Update with your desired AMI ID
  instance_type = "t3.medium"             # Update with your desired instance type

  # Configure security group
  vpc_security_group_ids = [aws_security_group.minecraft_server.id]

  # Configure user data to install Docker and start Minecraft server
  user_data_base64 = base64encode(file("./run.sh"))

}

# Create security group for Minecraft server
resource "aws_security_group" "minecraft_server" {
  name        = "minecraft-server"
  description = "Allow inbound traffic for Minecraft server"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "tls_private_key" "minecraft-server-jo" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "minecraft-server-jo" {
  key_name   = "minecraft_keyFinal"
  public_key = tls_private_key.minecraft-server-jo.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.minecraft-server-jo.private_key_pem}' > minecraft.pem"
  }
}

output "public_ip" {
  value = aws_instance.minecraft_server.public_ip
}

output "public_dns" {
  value = aws_instance.minecraft_server.public_dns
}

output "port" {
  value = "25565"
}
