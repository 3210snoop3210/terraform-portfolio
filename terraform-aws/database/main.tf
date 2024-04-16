#/database/main.tf

resource "aws_db_instance" "aws_db" {
  allocated_storage      = var.db_storage
  identifier             = var.db_identifier
  engine                 = "mysql"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpassword
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot    = var.skip_db_snapshot
  tags = {
    Name = "aws-db"
  }
}