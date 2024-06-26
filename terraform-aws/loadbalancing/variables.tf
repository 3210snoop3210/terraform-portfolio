#loadbalancing variables.tf

variable "public_sg" {

}

variable "public_subnets" {
  type = set(string)
}

variable "tg_port" {}

variable "tg_protocol" {}

variable "lb_healthy_threshold" {}

variable "lb_unhealthy_threshold" {}

variable "lb_timeout" {}

variable "lb_interval" {}

variable "vpc_id" {
  type = string
}

variable "listener_port" {}

variable "listener_protocol" {}