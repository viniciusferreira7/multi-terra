variable "target_group_name" {
  description = "Nome do target group"
  type        = string
  default     = "ec2-tg"
}

variable "target_group_port" {
  description = "Porta do target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocolo do target group"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "health_check_path" {
  description = "Caminho do health check"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Intervalo do health check"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout do health check"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Limite de verificações bem-sucedidas"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Limite de falhas antes de marcar como unhealthy"
  type        = number
  default     = 2
}

variable "health_check_matcher" {
  description = "Código de resposta esperado"
  type        = string
  default     = "200"
}

variable "target_id" {
  description = "ID da instância alvo"
  type        = string
}

variable "attachment_port" {
  description = "Porta usada pela instância"
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
    Name = "${var.alb_name}"
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
