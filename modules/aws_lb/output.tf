output "example_zone_id" {
  value = aws_lb.example.zone_id
}

output "example_dns_name" {
  value = aws_lb.example.dns_name
}

output "target_group_example_arn" {
  value = module.aws_lb_target_group.example_arn
}
