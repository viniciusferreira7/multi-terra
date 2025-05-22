variable "target_group_name" {
  description = "Target group name"
  type        = string
  default     = "ec2-tg"
}

variable "target_group_port" {
  description = "Target group port"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Target group protocol"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Health check interval"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of successful checks before considering the target healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of failed checks before considering the target unhealthy"
  type        = number
  default     = 2
}

variable "health_check_matcher" {
  description = "Expected response code"
  type        = string
  default     = "200"
}

variable "target_id" {
  description = "Target instance ID"
  type        = string
}

variable "attachment_port" {
  description = "Port used by the target instance"
  type        = number
  default     = 80
}

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
    Name = "alb"
    Iac = true
  }
  description = "Tags to apply to the ALB"
}

variable "alb_listener_port" {
  default     = 80
  description = "The port on which the Load Balancer listener will accept incoming traffic"
}

variable "alb_listener_protocol" {
  default     = "HTTP"
  description = "The protocol used by the Load Balancer listener (HTTP or HTTPS)"
}