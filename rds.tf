resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "mr-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

  tags = {
    Name = "MR DB Subnet Group"
  }
}

resource "aws_db_instance" "wordpressdb" {
  identifier        = "mr-mariadb"
  engine            = "mariadb"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_user
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "mr-mariadb-instance"
  }
}