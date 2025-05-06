data "aws_instance" "ec2" {
  instance_id = aws_instance.ec2_instance.id
}
