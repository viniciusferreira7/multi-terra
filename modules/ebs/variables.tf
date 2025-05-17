variable "name" {
  type        = string
  default     = ""
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
    Name = "${var.project_name}"
    Iac = true
  }
  description = "EBS tags"
}

variable "ec2_id" {
  type        = string
  default     = ""
  description = "ID of EC2"
}