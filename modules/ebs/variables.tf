variable "name" {
  type        = string
  default     = "${terraform.workspace}"
  description = "Name of EBS volume"
}

variable "size" {
  type        = number
  default     = 8
  description = "Size of EBS volume"
}

variable "type" {
  type        = number
  default     = 8
  description = "Type of EBS volume"
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "${var.project_name}-${terraform.workspace}"
    Iac = true
  }
  description = "EBS tags"
}

variable "ec2_id" {
  type        = string
  default     = ""
  description = "ID of EC2"
}