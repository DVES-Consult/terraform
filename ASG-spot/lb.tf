data "aws_vpc" "default" {
  id = "vpc-0b0665db5a711964d"
}

resource "aws_lb" "site_web_1" {
  name               = "site-web-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = ["subnet-0b8c9ea9e67946f7c", "subnet-0bfb81f2135f9b4f4", "subnet-041421edbf1981cb9"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "site_web_1" {
  load_balancer_arn = aws_lb.site_web_1.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.dves_cloud.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.site_web_1.arn
  }
}

resource "aws_lb_target_group" "site_web_1" {
  name = "site-web-1"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  lifecycle {
    create_before_destroy = true
  }
}
