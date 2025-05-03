
output "EC2_id" {
  value       = data.ec2.id
  sensitive   = true
  description = "ID of EC2"
}