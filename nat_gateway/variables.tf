variable "vpc_id" {
  description = "ID of the VPC for the NAT Gateways and route tables"
  type        = string
}

variable "public_subnet_a_id" {
  description = "ID of the first public subnet"
  type        = string
}

variable "public_subnet_b_id" {
  description = "ID of the second public subnet"
  type        = string
}

variable "private_subnet_a_id" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet_b_id" {
  description = "ID of the second private subnet"
  type        = string
}