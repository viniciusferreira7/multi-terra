# VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
}

# Subnet
variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "subnet_availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "subnet_map_public_ip_on_launch" {
  description = "Whether to assign public IPs on instance launch"
  type        = bool
}

variable "subnet_tags" {
  description = "Tags to apply to the subnet"
  type        = map(string)
}

# Internet Gateway
variable "gateway_tags" {
  description = "Tags to apply to the Internet Gateway"
  type        = map(string)
}

# Route Table
variable "route_cidr_block" {
  description = "Destination CIDR block for the route (usually 0.0.0.0/0)"
  type        = string
}

variable "route_tags" {
  description = "Tags to apply to the route table"
  type        = map(string)
}

# Security Group
variable "ssh_name" {
  description = "Name of the security group"
  type        = string
}

variable "ssh_description" {
  description = "Description of the security group"
  type        = string
}

variable "ssh_ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "Egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ssh_tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
}