variable "alb_name" {
  default     = "ec2-alb"
  description = "The name of the Application Load Balancer"
}

variable "alb_internal" {
  default     = false
  description = "Defines if the Load Balancer is internal (true) or internet-facing (false)"
}

variable "alb_type" {
  default     = "application"
  description = "The type of Load Balancer (application or network)"
}

variable "alb_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with the Load Balancer"
}

variable "alb_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the Load Balancer"
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "${var.alb_name}-${terraform.workspace}"
    Iac = true
  }
  description = "ALB tags"
}

variable "alb_listener_port" {
  default     = 80
  description = "The port on which the Load Balancer listener will accept incoming traffic"
}

variable "alb_listener_protocol" {
  default     = "HTTP"
  description = "The protocol used by the Load Balancer listener (HTTP or HTTPS)"
}
