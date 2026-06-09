terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# -----------------------
# Data Sources
# -----------------------

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  default_for_az    = true
  availability_zone = "us-west-2a"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# -----------------------
# Security Group
# -----------------------

resource "aws_security_group" "web_sg" {
  name        = "iacm-web-ssh-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-ssh-sg"
  }
}

# -----------------------
# EC2 Instance
# -----------------------

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = var.key_name

  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
echo "v2" > /etc/version
sudo yum update -y
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
EOF

  tags = {
    Name = var.name
  }
}

# -----------------------
# Outputs
# -----------------------

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}