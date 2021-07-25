resource "aws_vpc" "kubenetes_vpc" {
  cidr_block = "10.11.0.0/16"
  tags       = var.tags
}

resource "aws_internet_gateway" "kubenetes_gateway" {
  vpc_id = aws_vpc.kubenetes_vpc.id
  tags   = var.tags
}

resource "aws_route_table" "kubenetes_route_table" {
  vpc_id = aws_vpc.kubenetes_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # All Traffic
    gateway_id = aws_internet_gateway.kubenetes_gateway.id
  }

  tags = var.tags
}

resource "aws_subnet" "subnet_k8s" {
  vpc_id            = aws_vpc.kubenetes_vpc.id
  cidr_block        = "10.11.200.0/24"
  availability_zone = "us-east-1a"

  depends_on = [aws_vpc.kubenetes_vpc]
  tags       = var.tags
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_k8s.id
  route_table_id = aws_route_table.kubenetes_route_table.id
}

resource "aws_security_group" "allow_web_traffic" {
  name = "allow_web_traffic"
  # description = "Allow We b inbound traffic"
  vpc_id = aws_vpc.kubenetes_vpc.id

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
resource "aws_security_group" "k8s_master_node" {
  name = "k8s_master_node"
  # description = "Allow We b inbound traffic"
  vpc_id = aws_vpc.kubenetes_vpc.id

  ingress {
    description = ""
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = ""
    from_port   = 10250
    to_port     = 10252
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = ""
    from_port   = 2379
    to_port     = 2380
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
    Name = "k8s_master_node"
  }
}
