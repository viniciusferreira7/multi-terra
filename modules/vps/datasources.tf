data "aws_vpc" "main" {
  id = aws_vpc.main.id

  depends_on = [
    aws_vpc.main
  ]
}

data "aws_security_group" "ssh"  {
  id = aws_security_group.ssh.id

  depends_on = [
    aws_security_group.ssh
  ]
}

data "aws_subnet" "public" {
  id = aws_subnet.public.id

  depends_on = [
    aws_subnet.public,
  ]
}