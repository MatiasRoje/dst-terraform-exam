resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_a_id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [var.bastion_sg_id]
  tags = {
    Name = "mr-bastion-host"
  }
}

resource "aws_network_acl" "datascientest_public_a" {
  vpc_id = var.vpc_id

  subnet_ids = [var.public_subnet_a_id]

  tags = {
    Name = "mr-acl-datascientest-public-a"
  }
}

resource "aws_network_acl" "datascientest_public_b" {
  vpc_id = var.vpc_id

  subnet_ids = [var.public_subnet_a_id]

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
