variable "vpc_prefix" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_prefix" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.10.200.0/24"
}

variable "aws_instance_type" {
  description = "AWS Instance Type"
  type        = string
  default     = "t2.micro"
}
