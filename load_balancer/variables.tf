// load_balancer/variables.tf
variable "public_subnet_a_id" {
  description = "ID of the first public subnet"
  type        = string
}

variable "public_subnet_b_id" {
  description = "ID of the second public subnet"
  type        = string
}

variable "lb_sg_id" {
  description = "ID of the security group for the load balancer"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the load balancer is deployed"
  type        = string
}

variable "web_asg_id" {
  description = "The id of the aws_autoscaling_group"
  type = string
}