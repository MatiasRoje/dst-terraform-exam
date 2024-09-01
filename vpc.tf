resource "aws_vpc" "main" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "mr-main-vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_public_subnet_a
  availability_zone       = var.az_a
  map_public_ip_on_launch = true
  tags = {
    Name = "mr-public-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_public_subnet_b
  availability_zone       = var.az_b
  map_public_ip_on_launch = true
  tags = {
    Name = "mr-public-b"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_private_subnet_a
  availability_zone = var.az_a
  tags = {
    Name = "mr-private-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_private_subnet_b
  availability_zone = var.az_b
  tags = {
    Name = "mr-private-b"
  }
}

resource "aws_internet_gateway" "datascientest_igateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mr-datascientest-igateway"
  }
}

resource "aws_route_table" "rtb_public" {

  vpc_id = aws_vpc.main.id
  tags = {
    Name = "mr-datascientest-public-routetable"
  }
}

resource "aws_route" "route_igw" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.datascientest_igateway.id
}

resource "aws_route_table_association" "rta_subnet_association_puba" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta_subnet_association_pubb" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.rtb_public.id
}