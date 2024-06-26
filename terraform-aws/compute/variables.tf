#compute/variables.tf
variable "instance_type" {}
variable "instance_count" {}
variable "vol_size" {}
variable "public_sg" {}
variable "public_subnets" {}
variable "key_name" {}
variable "public_key_path" {}
variable "user_data_path" {}
variable "dbuser" {}
variable "dbname" {}
variable "dbpassword" {}
variable "db_endpoint" {}
variable "lb_target_group_arn" {}
variable "tg_port" {}
variable "private_key_path" {}