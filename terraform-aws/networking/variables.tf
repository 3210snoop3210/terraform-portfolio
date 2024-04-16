#/networking/variables.tf
variable "vpc_cidr" {
  type = string
  #default = "10.0.0.0/16"
}

variable "public_cidrs" {
  type = list(string)

}

variable "private_cidrs" {
  type = list(string)

}

variable "public_sn_cont" {
  type = number

}

variable "private_sn_count" {
  type = number

}

variable "max_subnets" {
  type = number

}

variable "access_ip" {
  type = string
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress = map(object({
      from       = number
      to         = number
      protocol   = string
      cidr_block = list(string)
    }))
  }))
}

variable "db_subnet_group" {
  type = bool
}
