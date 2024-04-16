output "image_out" {
  value       = docker_image.container_image.name
  description = "name Container."
}
