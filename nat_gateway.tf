# nat gateway a
resource "aws_eip" "eip_public_a" {
}

resource "aws_nat_gateway" "gw_public_a" {
  allocation_id = aws_eip.eip_public_a.id
  subnet_id     = aws_subnet.public_subnet_b.id
  tags = {
    Name = "mr-nat-public-a"
  }
}

resource "aws_route_table" "rtb_appa" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "mr-appa-routetable"
  }
}

resource "aws_route" "route_appa_nat" {
  route_table_id         = aws_route_table.rtb_appa.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw_public_a.id
}


resource "aws_route_table_association" "rta_subnet_association_appa" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.rtb_appa.id
}

# nat gateway b
resource "aws_eip" "eip_public_b" {
}

resource "aws_nat_gateway" "gw_public_b" {
  allocation_id = aws_eip.eip_public_b.id
  subnet_id     = aws_subnet.public_subnet_b.id

  tags = {
    Name = "mr-nat-public-b"
  }
}

resource "aws_route_table" "rtb_appb" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "mr-appb-routetable"
  }

}

resource "aws_route" "route_appb_nat" {
  route_table_id         = aws_route_table.rtb_appb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw_public_b.id
}

resource "aws_route_table_association" "rta_subnet_association_appb" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.rtb_appb.id
}

