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

module "aws_nat_gateway" {
  source                       = "./modules/aws_nat_gateway"
  aws_subnet_public_0_id       = module.aws_subnet.aws_subnet_public_0_id
  aws_subnet_public_1_id       = module.aws_subnet.aws_subnet_public_1_id
  aws_internet_gateway_example = module.aws_vpc.aws_internet_gateway_example
}

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
  source                           = "./modules/aws_subnet"
  aws_vpc_id                       = module.aws_vpc.aws_vpc_example_id
  aws_internet_gateway_example_id  = module.aws_vpc.aws_internet_gateway_example.id
  aws_nat_gateway_nat_gateway_0_id = module.aws_nat_gateway.aws_nat_gateway_nat_gateway_0_id
  aws_nat_gateway_nat_gateway_1_id = module.aws_nat_gateway.aws_nat_gateway_nat_gateway_1_id
}

module "aws_vpc" {
  source = "./modules/aws_vpc"
}
