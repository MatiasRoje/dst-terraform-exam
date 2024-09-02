resource "aws_lb" "web_lb" {
  name               = "mr-lb"
  internal           = false
  load_balancer_type = "application"

  subnets         = [var.public_subnet_a_id, var.public_subnet_b_id]
  security_groups = [var.lb_sg_id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/wp-admin/install.php"
    protocol            = "HTTP"
    matcher             = "200,301,302"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_autoscaling_attachment" "tg_attachment" {
  autoscaling_group_name = var.web_asg_id
  lb_target_group_arn    = aws_lb_target_group.web_tg.arn
}
