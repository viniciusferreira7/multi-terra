variable "ebs_size" {
  type        = number
  default     = 8
  description = "Size of EBS volume"
}

variable "ebs_tags" {
  type        = map(string)
  default     = {}
  description = "S3 tags"
}
