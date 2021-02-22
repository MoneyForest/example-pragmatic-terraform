data "aws_route53_zone" "example" {
  name = "makemoneyforest.com"
}

resource "aws_route53_record" "example" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = data.aws_route53_zone.example.name
  type    = "A"

  alias {
    zone_id                = var.aws_lb_example_zone_id
    name                   = var.aws_lb_example_dns_name
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "example_certificate" {
  for_each = {
    for dvo in var.aws_acm_certificate_example_domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.id
  ttl             = 60
}

module "aws_acm" {
  source                                 = "../aws_acm"
  aws_route53_record_example_name        = aws_route53_record.example.name
  aws_route53_record_example_certificate = aws_route53_record.example_certificate
}
