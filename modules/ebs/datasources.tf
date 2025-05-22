data "aws_ebs_volume" "ebs" {
   depends_on = [
    aws_ebs_volume.ebs
  ]
}