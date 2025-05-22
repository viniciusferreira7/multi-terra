
resource "aws_kms_key" "ebs_key" {
  description = "Key KMS of EBS volume"
  enable_key_rotation = var.enable_key_rotation
}

resource "aws_kms_alias" "ebs_key_alias" {
  name = "${var.name}"
  target_key_id = aws_kms_key.ebs_key.id

   depends_on = [
    aws_kms_key.ebs_key
  ]
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type
  encrypted = true
  kms_key_id = aws_kms_key.ebs_key.arn

  tags = var.tags

   depends_on = [
    aws_kms_key.ebs_key
  ]
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = var.ec2_id

   depends_on = [
    aws_ebs_volume.ebs
  ]
}
