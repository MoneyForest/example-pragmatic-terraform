data "aws_route53_zone" "example" {
  name = "makemoneyforest.com"
}

resource "aws_route53_record" "example" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = data.aws_route53_zone.example.name
  type    = "A"

  alias {
    zone_id                = aws_lb.example.zone_id
    name                   = aws_lb.example.dns_name
    evaluate_target_health = true
  }
}

output "domain_name" {
  value = aws_route53_record.example.name
}
