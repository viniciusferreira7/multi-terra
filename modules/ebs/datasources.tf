data "aws_ebs_volume" "ebs" {
  availability_zone = aws_ebs_volume.ebs.availability_zone

   depends_on = [
    aws_ebs_volume.ebs
  ]
}