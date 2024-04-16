#loadbalancing/outputs.tf
output "lb_target_group_arn" {
  value = aws_lb_target_group.aws_tg.arn
}

output "lb_endpoint" {
  value = aws_lb.aws_lb.dns_name
}
