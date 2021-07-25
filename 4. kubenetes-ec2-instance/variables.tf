variable "tags" {
  description = "The tag name for every same virtual private cloud"
  type        = map(string)
  default     = { "Name" : "K8S" }
}
