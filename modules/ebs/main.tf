// Follow the trail: https://chatgpt.com/c/6810b33e-b5d4-8009-84b8-a3d488ca7b9a

resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-1"
  size              = var.ebs_size
  # encrypted = true //TODO: Think about this point

  tags = var.s3_tags
}