output "web_asg_id" {
  description = "The id of the aws_autoscaling_group"
  value = aws_autoscaling_group.web_asg.id
}