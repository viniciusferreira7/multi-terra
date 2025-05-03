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

variable "ebs_type" {
  type        = number
  default     = 8
  description = "Type of EBS volume"
}

variable "ebs_tags" {
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


//TODO: criar IAM
//TODO: criar um backend para salvar o estado
// Follow the trail about Secure EBS module: https://chatgpt.com/c/6810b33e-b5d4-8009-84b8-a3d488ca7b9a
