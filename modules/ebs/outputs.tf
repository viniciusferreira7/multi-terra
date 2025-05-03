output "ebs_volume_id" {
  value       = data.ebs.id
  sensitive   = true
  description = "ID of EBS volume"
}

