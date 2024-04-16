resource "docker_volume" "container_volume" {
  name = "${var.name_in}-volume"
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir ${path.cwd}/../backup/"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
    on_failure = fail
  }
}