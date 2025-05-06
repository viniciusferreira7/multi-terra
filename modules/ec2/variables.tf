variable "ami_id" {
  description = "ID of the AMI to be used"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance into"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}

variable "iam_instance_profile" {
  description = "IAM instance profile to associate with the instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Startup script (user data) to run on instance launch"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 10
}

variable "root_volume_type" {
  description = "Type of the root volume (e.g., gp2, gp3)"
  type        = string
  default     = "gp2"
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default     = {
    Name = "DefaultServer"
  }
}