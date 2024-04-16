/*output "containername" {
    value = docker_container.nodered_container.name
    description = "name Container."

}

output "ipaddress" {
    value = [for i in docker_container.nodered_container[*]: join(": ", [i.name],[i.network_data[0].ip_address],i.ports[*]["external"])]
    description = "IP Container"
}*/

output "app_access" {
  value = {
    for x in docker_container.app_container[*] : x.name => join(":", [x.network_data[0].ip_address], x.ports[*]["external"])
  }
}