output "http_arn" {
  value = aws_lb_listener.http.arn
}

output "https_arn" {
  value = aws_lb_listener.https.arn
}

output "redirect_http_to_https_arn" {
  value = aws_lb_listener.redirect_http_to_https.arn
}