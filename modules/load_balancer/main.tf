resource "aws_lb" "load_balancer" {
  name               = var.name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.security_groups]
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.listener_port
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}