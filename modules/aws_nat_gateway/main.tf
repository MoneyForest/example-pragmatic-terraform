resource "aws_eip" "nat_gateway_0" {
  vpc        = true
  depends_on = [var.aws_internet_gateway_example]
}

resource "aws_eip" "nat_gateway_1" {
  vpc        = true
  depends_on = [var.aws_internet_gateway_example]
}

resource "aws_nat_gateway" "nat_gateway_0" {
  allocation_id = aws_eip.nat_gateway_0.id
  subnet_id     = var.aws_subnet_public_0_id
  depends_on    = [var.aws_internet_gateway_example]
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = var.aws_subnet_public_1_id
  depends_on    = [var.aws_internet_gateway_example]
}
