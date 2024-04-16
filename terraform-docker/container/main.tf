resource "docker_container" "app_container" {
  name  = var.name_in
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in
  }
  dynamic volumes {
    for_each = var.volumes
    content {
    container_path = volumes.value["container_path_each"]
    volume_name    = docker_volume.container_volume.name
    }
  }
  provisioner "local-exec" {
    command = "echo ${self.name}: ${self.network_data[0].ip_address}:${join("", [for x in self.ports[*]["external"] : x])} >> containers.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }
}
module "volume" {
  source = "./volume"
  volume_name = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}