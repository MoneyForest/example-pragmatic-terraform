# プライベートサブネット①
resource "aws_subnet" "private_0" {
  vpc_id                  = var.aws_vpc_id
  cidr_block              = "10.0.65.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"
}

# プライベートサブネット②
resource "aws_subnet" "private_1" {
  vpc_id                  = var.aws_vpc_id
  cidr_block              = "10.0.66.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"
}

# プライベートルートテーブル①
resource "aws_route_table" "private_0" {
  vpc_id = var.aws_vpc_id
}

# プライベートルートテーブル②
resource "aws_route_table" "private_1" {
  vpc_id = var.aws_vpc_id
}

# プライベートサブネット①とルートテーブル①の関連付け
resource "aws_route_table_association" "private_0" {
  subnet_id      = aws_subnet.private_0.id
  route_table_id = aws_route_table.private_0.id
}

# プライベートサブネット②とルートテーブル②の関連付け
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

// # プライベートルート①
// resource "aws_route" "private_0" {
//   route_table_id         = aws_route_table.private_0.id
//   nat_gateway_id         = aws_nat_gateway.nat_gateway_0.id
//   destination_cidr_block = "0.0.0.0/0"
// }

// # プライベートルート②
// resource "aws_route" "private_1" {
//   route_table_id         = aws_route_table.private_1.id
//   nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id
//   destination_cidr_block = "0.0.0.0/0"
// }
