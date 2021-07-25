terraform {
  # backend "remote" {
  #   organization = "kaonmir"
  #   workspaces {
  #     name = "terraform-course-practice"
  #   }
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-east-1"
}

# 1. Create VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = var.vpc_prefix
  tags = {
    "Name" = "Production"
  }
}

# 2. Create Internet Gateway
resource "aws_internet_gateway" "prod-gateway" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    "Name" = "Production"
  }
}

# 3. Create Custom Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0" # All Traffic
    gateway_id = aws_internet_gateway.prod-gateway.id
  }

  tags = {
    Name = "Production"
  }
}

# 4. Create a Subnet for VPC(#2)
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = var.subnet_prefix
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}

# 5. Associate Route Table(#3) with Subnet(#4)
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}

# 6. Create Security Group to allow port 22, 80, 443
resource "aws_security_group" "allow_web_traffic" {
  name        = "allow_web_traffic"
  description = "Allow We b inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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

  ingress {
    description = "SSH"
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

  tags = {
    Name = "allow_web"
  }
}

# 7. Create a (elastic) network interface with an IP in the subnet(#4)
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.10.200.50"]
  security_groups = [aws_security_group.allow_web_traffic.id]
}

# 8. Assign an elastic IP to the network interface(#7)
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.10.200.50"
  depends_on                = [aws_internet_gateway.prod-gateway]
}

# 9. Create Ubuntu Server and install/run apache2
resource "aws_instance" "web-server-instance" {
  ami               = "ami-09e67e426f25ce0d7"
  instance_type     = var.aws_instance_type
  availability_zone = "us-east-1a"
  key_name          = "AWS_K8S"

  network_interface {
    network_interface_id = aws_network_interface.web-server-nic.id
    device_index         = 0
  }

  # # user_data = file("./user_data.sh")
  # user_data = <<-EOF
  #   #!bin/bash
  #   sudo apt update -y
  #   sudo apt install -y apache2
  #   sudo systemctl start apache
  #   sudo bash -c 'echo your very first web server > /var/www/html/index.html'
  # EOF

  tags = {
    Name = "web-server"
  }
}
