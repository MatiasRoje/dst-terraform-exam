resource "aws_vpc" "main" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "mr-main-vpc"
  }
}

resource "aws_internet_gateway" "datascientest_igateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mr-datascientest-igateway"
  }
}

