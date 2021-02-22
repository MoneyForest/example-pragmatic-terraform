output "aws_lb_listener_http_arn" {
  value = aws_lb_listener.http.arn
}

output "aws_lb_listener_https_arn" {
  value = aws_lb_listener.https.arn
}

output "aws_lb_listener_redirect_http_to_https_arn" {
  value = aws_lb_listener.redirect_http_to_https.arn
}