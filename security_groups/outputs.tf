output "web_sg_id" {
  description = "The ID of the web security group"
  value       = aws_security_group.web_sg.id
}

output "db_sg_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db_sg.id
}

output "lb_sg_id" {
  description = "The ID of the load balancer security group"
  value       = aws_security_group.lb_sg.id
}

output "bastion_sg_id" {
  description = "The ID of the bastion security group"
  value       = aws_security_group.bastion_sg.id
}