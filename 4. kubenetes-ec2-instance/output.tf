output "server_public_ip" {
  value = aws_eip.one.public_ip
}

output "server_id" {
  value = aws_instance.kubernetes_master.id
}

output "master_node_private_ip" {
  value = aws_instance.kubernetes_master.public_ip
}
