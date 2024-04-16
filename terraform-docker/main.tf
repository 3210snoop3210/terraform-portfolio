module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source = "./container"
  for_each = local.deployment
  name_in  = join("-", [each.key, terraform.workspace, random_string.random[each.key].result])
  image_in = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext[0]
  #container_path_in = each.value.container_path
  #host_path_in = "${path.cwd}/noderedvol"
  #volumes_in = each.value.volumes
  volumes = local.deployment[each.key].volumes

}

resource "docker_image" "nodered_image" {
  name = var.image["nodered"][terraform.workspace]
}

resource "docker_image" "influxdb_image" {
  name = var.image["influxdb"][terraform.workspace]
}

resource "docker_image" "grafana_image" {
  name = var.image["grafana"][terraform.workspace]
}

resource "random_string" "random" {
  for_each = local.deployment
  length   = 4
  special  = false
  upper    = false
}

/*resource "random_string" "random2" {
    length =4
    special = false
    upper = false
}

resource "docker_container" "nodered_container2" {
  name  = join("-",["nodered", random_string.random2.result])
  image = docker_image.nodered_image.name
  ports {
    internal = "1880"
   # external = "1880"
  }
}

output "all_attributes" {
  value = {
    for attr in keys(docker_container.nodered_container) : attr => docker_container.nodered_container[attr]
  }
}

output "c0ntainername" {
    value = docker_container.nodered_container.name
    description = "IP Container"

}*/

/*module "influxdb_image" {
  source = "./image"
  image_in = var.image["influxdb"][terraform.workspace]
}*/