output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "The DNS name of the ALB"
}

output "target_group_arn" {
  value       = aws_lb_target_group.tg.arn
  description = "The ARN of the ALB Target Group"
}

output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "The ARN of the ALB"
}
