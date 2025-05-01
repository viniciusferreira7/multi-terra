
resource "aws_kms_key" "ebs_key" {
  description = "Key KMS of EBS volume"
  enable_key_rotation = 10
}

resource "aws_kms_alias" "ebs_key_alias" {
  name = "${var.ebs_name}-${terraform.workspace}"
  target_key_id = aws_kms_key.ebs_key.id

   depends_on = [
    aws_kms_key.ebs_key
  ]
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-1"
  size              = var.ebs_size
  type              = var.ebs_type
  encrypted = true
  kms_key_id = aws_kms_key.ebs_key.arn

  tags = var.ebs_tags

   depends_on = [
    aws_kms_key.ebs_key
  ]
}