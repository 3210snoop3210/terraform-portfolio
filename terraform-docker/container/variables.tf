variable "ext_port_in" {}
variable "int_port_in" {}
#variable "container_path_in" {}
variable "image_in" {}
variable "name_in" {}
#variable "count_in" {}
#variable "volumes_in" {}
variable "volumes" {
  description = "A list of volumes for the Docker container"
  type        = list(object({
    container_path_each = string
  }))
  default     = []
}