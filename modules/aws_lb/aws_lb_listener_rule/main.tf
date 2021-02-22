resource "aws_lb_listener_rule" "example" {
  listener_arn = var.aws_lb_listener_https_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = var.aws_lb_target_group_example_arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
