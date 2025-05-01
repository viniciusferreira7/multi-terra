
resource "aws_kms_key" "ebs_key" {
  description = "Key KMS of EBS volume"
  enable_key_rotation = 10
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-1"
  size              = var.ebs_size
  encrypted = true

  tags = var.ebs_tags

   depends_on = [
    aws_kms_key.s3_bucket
  ]
}