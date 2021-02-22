resource "aws_lb" "example" {
  name                       = "example"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    var.aws_subnet_public_0_id,
    var.aws_subnet_public_1_id,
  ]

  access_logs {
    bucket  = var.aws_s3_bucket_alb_log_id
    enabled = true
  }

  security_groups = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
    module.http_redirect_sg.security_group_id,
  ]
}

module "http_sg" {
  source      = "../aws_security_group"
  name        = "http-sg"
  vpc_id      = var.aws_vpc_example_id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "../aws_security_group"
  name        = "https-sg"
  vpc_id      = var.aws_vpc_example_id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "http_redirect_sg" {
  source      = "../aws_security_group"
  name        = "https-redirect-sg"
  vpc_id      = var.aws_vpc_example_id
  port        = 8080
  cidr_blocks = ["0.0.0.0/0"]
}

module "aws_lb_listener" {
  source                          = "./aws_lb_listener"
  aws_lb_example_arn              = aws_lb.example.arn
  aws_acm_certificate_example_arn = var.aws_acm_certificate_example_arn
}

module "aws_lb_listerner_rule" {
  source                          = "./aws_lb_listener_rule"
  aws_lb_listener_https_arn       = module.aws_lb_listener.aws_lb_listener_https_arn
  aws_lb_target_group_example_arn = module.aws_lb_target_group.aws_lb_target_group_example_arn
}

module "aws_lb_target_group" {
  source             = "./aws_lb_target_group"
  aws_vpc_example_id = var.aws_vpc_example_id
  aws_lb_example     = aws_lb.example
}
