
output "vpc_id" {
  value       = data.aws_vpc.main.id
  sensitive   = true
  description = "ID of VPC"
}

output "subnet_id" {
  value       = data.aws_subnet.public.id
  sensitive   = false
  description = "ID subnet"
}

output "security_group_ids" {
  value       = data.aws_security_group.ssh.id
  sensitive   = true
  description = "ID of SSH"
}

output "security_group_alb_sg_id" {
  value       = data.aws_security_group.alb_sg.id
  sensitive   = true
  description = ""
}

//TODO: adicionar o load balance
//TODO: adicionar o backend