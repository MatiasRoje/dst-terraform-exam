output "nat_gateway_public_a_id" {
  description = "The ID of the NAT Gateway in public subnet A"
  value       = aws_nat_gateway.gw_public_a.id
}

output "nat_gateway_public_b_id" {
  description = "The ID of the NAT Gateway in public subnet B"
  value       = aws_nat_gateway.gw_public_b.id
}