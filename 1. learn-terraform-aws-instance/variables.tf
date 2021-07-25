variable "instance_name" {
  description = "Value of the name tag for EC2 instance"
  type        = string
  default     = "SampleInstanceOfKaonmir"
}

variable "instance_ami" {
  description = "specific code of the AMI for EC2 instance"
  type        = string
  default     = "ami-0dc8f589abe99f538"
}
