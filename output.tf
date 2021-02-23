output "aws_lb_example_dns_name" {
  value = module.aws_lb.example_dns_name
}

output "aws_route53_record_example_name" {
  value = module.aws_route53_record.example_name
}

output "iam_role_arn" {
    value = module.aws_ecs.iam_role_arn
}