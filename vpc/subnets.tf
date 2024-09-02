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