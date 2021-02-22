terraform {
  required_version = "0.14.6"
  required_providers {
    aws = {
      version = "3.28.0"
    }
  }
}

module "aws_acm" {
  source                                 = "./modules/aws_acm"
  aws_route53_record_example_name        = module.aws_route53_record.example_name
  aws_route53_record_example_certificate = module.aws_route53_record.example_certificate
}

// module "aws_cloudwatch" {
//   source = "./modules/aws_cloudwatch"
// }

// module "aws_ecs" {
//   source = "./modules/aws_ecs"
// }

module "aws_lb" {
  source                          = "./modules/aws_lb"
  aws_subnet_public_0_id          = module.aws_subnet_public_0_id
  aws_subnet_public_1_id          = module.aws_subnet_public_1_id
  aws_s3_bucket_alb_log_id        = module.aws_s3_bucket.alb_log_id
  aws_vpc_example_id              = module.aws_vpc.example_id
  aws_acm_certificate_example_arn = module.aws_route53.aws_acm_certificate_example_arn
}

module "aws_nat_gateway" {
  source                       = "./modules/aws_nat_gateway"
  aws_subnet_public_0_id       = module.aws_subnet.aws_subnet_public_0_id
  aws_subnet_public_1_id       = module.aws_subnet.aws_subnet_public_1_id
  aws_internet_gateway_example = module.aws_vpc.aws_internet_gateway_example
}

module "aws_route53_record" {
  source                  = "./modules/aws_route53_record"
  aws_lb_example_zone_id  = module.aws_lb.example_zone_id
  aws_lb_example_dns_name = module.aws_lb.example_dns_name
}

module "aws_s3_bucket" {
  source = "./modules/aws_s3_bucket"
}

module "aws_subnet" {
  source                           = "./modules/aws_subnet"
  aws_vpc_example_id               = module.aws_vpc.example_id
  aws_internet_gateway_example_id  = module.aws_vpc.aws_internet_gateway_example.id
  aws_nat_gateway_nat_gateway_0_id = module.aws_nat_gateway.nat_gateway_0_id
  aws_nat_gateway_nat_gateway_1_id = module.aws_nat_gateway.nat_gateway_1_id
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
}
