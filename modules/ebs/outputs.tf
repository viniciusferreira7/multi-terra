output "ebs_volume_id" {
  value       = data.aws_ebs_volume.ebs.id
  sensitive   = true
  description = "ID of EBS volume"
}

