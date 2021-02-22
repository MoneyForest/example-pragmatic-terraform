output "domain_name" {
  value = aws_route53_record.example.name
}

output "aws_acm_certificate_example_arn" {
  value = module.aws_acm.aws_acm_certificate_example_arn
}