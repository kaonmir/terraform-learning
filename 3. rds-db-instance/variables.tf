
variable "mysql_db_username" {
  description = "Username for Mysql Database"
  type        = string
  default     = "kaonmir"
}

variable "mysql_db_password" {
  description = "Password for Mysql Database"
  type        = string
  default     = "mirmirkaonkaon" # Longer than 8 characters
  sensitive   = true
}
