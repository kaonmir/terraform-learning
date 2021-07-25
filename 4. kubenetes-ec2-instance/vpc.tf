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
  cidr_block        = "10.11.150.0/24"
  availability_zone = "us-east-1a"

  depends_on = [aws_vpc.kubenetes_vpc]
  tags       = var.tags
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_k8s.id
  route_table_id = aws_route_table.kubenetes_route_table.id
}
