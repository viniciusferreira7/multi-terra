data "aws_lb" "alb" {
  name = aws_lb.alb.name

  depends_on = [
    aws_lb.alb
  ]
}

data "aws_lb_target_group" "tg" {
  name = aws_lb_target_group.tg.name

  depends_on = [
    aws_lb_target_group.tg
  ]
}

