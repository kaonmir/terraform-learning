
# Master Node of K8S
resource "aws_network_interface" "master_node_nic" {
  subnet_id   = aws_subnet.subnet_k8s.id
  private_ips = ["10.11.200.30"]
  security_groups = [
    aws_security_group.allow_web_traffic.id,
    aws_security_group.k8s_master_node.id
  ]
  depends_on = [aws_subnet.subnet_k8s]
}

resource "aws_eip" "one" {
  vpc               = true
  network_interface = aws_network_interface.master_node_nic.id
  #   associate_with_private_ip = aws_network_interface.worker_node_nic.private_ip
  associate_with_private_ip = "10.11.200.30"
  depends_on = [
    aws_internet_gateway.kubenetes_gateway,
    aws_network_interface.master_node_nic
  ]
}

resource "aws_instance" "kubernetes_master" {
  ami               = "ami-0dc2d3e4c0f9ebd18"
  instance_type     = "t3.medium"
  availability_zone = "us-east-1a"
  key_name          = "AWS_K8S"

  network_interface {
    network_interface_id = aws_network_interface.master_node_nic.id
    device_index         = 0
  }

  tags = var.tags
}

# Worker Node

resource "aws_network_interface" "worker_node_nic_1" {
  subnet_id   = aws_subnet.subnet_k8s.id
  private_ips = ["10.11.200.50"]
  security_groups = [
    aws_security_group.allow_web_traffic.id,
    aws_security_group.k8s_worker_node.id
  ]
  depends_on = [aws_subnet.subnet_k8s]
}

resource "aws_instance" "kubernetes_master" {
  ami               = "ami-0dc2d3e4c0f9ebd18"
  instance_type     = "t3.medium"
  availability_zone = "us-east-1a"
  key_name          = "AWS_K8S"

  network_interface {
    network_interface_id = aws_network_interface.worker_node_nic_1.id
    device_index         = 0
  }

  tags = var.tags
}

