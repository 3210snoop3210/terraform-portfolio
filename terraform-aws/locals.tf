#/root/locals.tf

locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "SG for public access."
      ingress = {
        open = {
          from       = 0
          to         = 0
          protocol   = -1
          cidr_block = [var.access_ip]
        }
        http = {
          from       = 80
          to         = 80
          protocol   = "tcp"
          cidr_block = ["0.0.0.0/0"]
        }
        nginx = {
          from       = 8000
          to         = 8000
          protocol   = "tcp"
          cidr_block = ["0.0.0.0/0"]
        }
      }
    }
    rds = {
      name        = "rds_sg"
      description = "rds_access"
      ingress = {
        mysql = {
          from       = 3306 # Add this line
          to         = 3306 # Add this line
          protocol   = "tcp"
          cidr_block = ["10.123.0.0/16"]
        }
      }
    }
  }
}