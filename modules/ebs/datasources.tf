data "aws_ebs_volume" "ebs" {
  availability_zone = aws_ebs_volume.ebs.availability_zone
  volume_id = aws_ebs_volume.ebs.id

   depends_on = [
    aws_ebs_volume.ebs
  ]
}