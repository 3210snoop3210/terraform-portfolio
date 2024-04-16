#/networking/outputs.tf
output "vpc_id" {
  value = aws_vpc.aws_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.aws_rds_subnetgroup.*.name
}

output "db_security_group" {
  value = [aws_security_group.aws_sg["rds"].id]
}

output "public_sg" {
  value = aws_security_group.aws_sg["public"].id
}

output "public_subnets" {

  value = aws_subnet.aws_pub_sub.*.id
}