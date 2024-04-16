/*output "containername" {
    value = module.container[*].containername
    description = "name Container."

}


output "ipaddress" {
    value = flatten(module.container[*].ipaddress)
    description = "IP Container"
}

output "workspace" {
  value = terraform.workspace
}
*/
/*output "ipaddress" {
    value = join(":", flatten([docker_container.nodered_container[*].network_data[0].ip_address, docker_container.nodered_container[*].ports[0].external]))
    description = "IP Container"
}*/

output "app_access" {
  value       = [for x in module.container[*] : x]
  description = "name and socket for each app."
}