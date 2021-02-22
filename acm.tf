# ACMは証明書の更新の管理を担ってくれるマネージドサービス
# domain_nameにドメイン名を設定する
# subject_alternative_namesはドメイン名を追加したい場合に設定する
# validation_methodは検証方法、DNSかEメール
# lifecycleにcreate_before_destroyを設定することで新しい証明書を作ってから削除するという
# 挙動にすることで影響を最小限にすることができる。
resource "aws_acm_certificate" "example" {
  domain_name               = aws_route53_record.example.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# 検証用DNSレコードの追加
resource "aws_route53_record" "example_certificate" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
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

# SSL証明書の検証が完了するまで待つ
resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example_certificate : record.fqdn]
}
