variable "ec2_ami" {
  type        = string
  default     = ""
  description = "AMI of EC2"
}

variable "ec2_instance_type" {
  type        = string
  default     = ""
  description = "Instance type of EC2"
}

variable "ec2_host_resource_group_arn" {
  type        = string
  default     = ""
  description = "Host resource group arn of EC2"
}
