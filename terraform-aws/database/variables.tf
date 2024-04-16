#/database/variables.tf
variable "db_storage" {}
variable "db_identifier" {
  type = string
  # Ensure the value contains only lowercase alphanumeric characters and hyphens
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.db_identifier))
    error_message = "Only lowercase alphanumeric characters and hyphens are allowed in db_identifier."
  }
}
variable "db_engine_version" {}
variable "db_instance_class" {}
variable "dbuser" {}
variable "dbname" {}
variable "dbpassword" {}
variable "db_subnet_group_name" {
  type = string
}
variable "vpc_security_group_ids" {}
variable "skip_db_snapshot" {}