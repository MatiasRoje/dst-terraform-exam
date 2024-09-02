output "load_balancer_arn" {
  value = aws_lb.web_lb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.web_tg.arn
}