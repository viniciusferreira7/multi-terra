variable "ebs_name" {
  type        = string
  default     = "${terraform.workspace}"
  description = "Name of EBS volume"
}

variable "ebs_size" {
  type        = number
  default     = 8
  description = "Size of EBS volume"
}

variable "ebs_tags" {
  type        = map(string)
  default     = {
    Name = "${var.project_name}-${terraform.workspace}"
    Iac = true
  }
  description = "EBS tags"
}
