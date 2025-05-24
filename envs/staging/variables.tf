variable "state_bucket" {
  type        = string
  default     = ""
  description = "State of bucket"
}

variable "profile" {
  description = "AWS profile configured in CLI"
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "subnet_availability_zone" {}
variable "route_cidr_block" {}

variable "ssh_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "iam_instance_profile" {}

variable "alb_name" {}
variable "target_group_name" {}

variable "environment" {
  default = "dev"
}
