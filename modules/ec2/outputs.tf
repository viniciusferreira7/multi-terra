
output "id" {
  value       = data.aws_instance.ec2.id
  sensitive   = true
  description = "ID of EC2"
}