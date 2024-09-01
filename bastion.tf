resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_a.id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags = {
    Name = "mr-bastion-host"
  }
}

resource "aws_network_acl" "datascientest_public_a" {
  vpc_id = aws_vpc.main.id

  subnet_ids = [aws_subnet.public_subnet_a.id]

  tags = {
    Name = "mr-acl-datascientest-public-a"
  }
}

resource "aws_network_acl" "datascientest_public_b" {
  vpc_id = aws_vpc.main.id

  subnet_ids = [aws_subnet.public_subnet_b.id]

  tags = {
    Name = "mr-acl-datascientest-public-b"
  }
}

resource "aws_network_acl_rule" "nat_inbound" {
  network_acl_id = aws_network_acl.datascientest_public_a.id
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "nat_inboundb" {
  network_acl_id = aws_network_acl.datascientest_public_b.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
