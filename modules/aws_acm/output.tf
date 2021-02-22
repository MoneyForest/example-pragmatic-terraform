output "certificate_example_arn" {
  value = aws_acm_certificate.example.arn
}

output "certificate_example_domain_validation_options" {
  value = aws_acm_certificate.example.domain_validation_options
}
