resource "aws_target_group" "target_groups" {
  name     = var.name
  vpc_id   = var.vpc_id
  port     = var.target_group_port
  protocol = "HTTP"

  health_check {
    path                = "/"
    port                = var.health_check_port
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 5
    timeout             = 4
    matcher             = "200"
  }
}