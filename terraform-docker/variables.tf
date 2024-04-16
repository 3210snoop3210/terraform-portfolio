variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana:latest"
      prod = "grafana/grafana:latest"
    }
  }
}

variable "int_port" {
  type = number

}

variable "ext_port" {
  type = map(any)
}


locals {
  cont_counts = {
    for key, value in local.deployment : key => length(value.ext)
  }
}