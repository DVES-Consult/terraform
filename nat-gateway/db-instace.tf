resource "aws_db_instance" "db_mysql" {
  identifier             = "database-1"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "12345678"
  parameter_group_name   = "default.mysql8.0"
  copy_tags_to_snapshot  = true
  skip_final_snapshot    = true
  storage_encrypted      = true
  storage_type           = "gp2"
  max_allocated_storage  = 990
  db_subnet_group_name = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.db_sql.id, aws_security_group.ssh.id]
}

resource "aws_db_subnet_group" "private" {
  name       = "private"
  subnet_ids = [aws_subnet.private_subnet_b.id, aws_subnet.private_subnet_c.id]

  tags = {
    Name = "My DB subnet group"
  }
}