// module "aws_cloudwatch" {
//   source = "./modules/aws_cloudwatch"
// }

// module "aws_ecs" {
//   source = "./modules/aws_ecs"
// }

// module "aws_iam" {
//   source = "./modules/aws_iam"
// }

// module "aws_lb" {
//   source = "./modules/aws_lb"
// }

// module "aws_nat_gateway" {
//   source = "./modules/aws_nat_gateway"
// }

// module "aws_route53" {
//   source = "./modules/aws_route53"
// }

module "aws_s3" {
  source = "./modules/aws_s3"
}

// module "aws_security_group" {
//   source = "./modules/aws_security_group"
// }

module "aws_subnet" {
  source = "./modules/aws_subnet"
  aws_vpc_id = module.aws_vpc.id
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
}
