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
    Name = "ebs"
    Iac = true
  }
  description = "EBS tags"
}

variable "ec2_id" {
  type        = string
  default     = ""
  description = "ID of EC2"
}

variable "availability_zone" {
  type        = string
  default     = ""
  description = "Availability Zone of EBS"
}

variable "enable_key_rotation" {
  type        = string
  default     = ""
  description = "Enable rotation of key"
}