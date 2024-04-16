locals {
  deployment = {
    /*    nodered = {
      image = var.image["nodered"][terraform.workspace]
      int = 1880
      ext = var.ext_port["nodered"][terraform.workspace]
      container_path = "/data"
    }
    influxdb = {
      image =var.image["influxdb"][terraform.workspace]
      int = 8086
      ext = var.ext_port["influxdb"][terraform.workspace]
      container_path = "/var/lib/influxdb"
    }*/
    grafana = {
      image = var.image["grafana"][terraform.workspace]
      int   = 3000
      ext   = var.ext_port["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}