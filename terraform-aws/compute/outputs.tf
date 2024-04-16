#compute/outputs.tf
output "instance" {
  value     = aws_instance.aws_node[*]
  sensitive = true
}

output "instance_port" {
  value = aws_lb_target_group_attachment.aws_tg_attach[0].port
}
