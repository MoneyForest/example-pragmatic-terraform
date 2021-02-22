module "private" {
  source                           = "./private"
  aws_vpc_id                       = var.aws_vpc_id
  aws_nat_gateway_nat_gateway_0_id = var.aws_nat_gateway_nat_gateway_0_id
  aws_nat_gateway_nat_gateway_1_id = var.aws_nat_gateway_nat_gateway_1_id
}

module "public" {
  source                          = "./public"
  aws_vpc_id                      = var.aws_vpc_id
  aws_internet_gateway_example_id = var.aws_internet_gateway_example_id
}
