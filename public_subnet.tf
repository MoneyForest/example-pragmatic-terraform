# こだわりがなければサブネットではCIDRブロックは/24単位がおすすめ
# map_public_ip_on_launchでそのサブネットで起動したインスタンスにパブリックIPを自動割り当て
# 便利なのでパブリックネットワークではtrueに

# パブリックサブネット①
resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
}

# パブリックサブネット②
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
}

# パブリックルートテーブル①
resource "aws_route_table" "public_0" {
  vpc_id = aws_vpc.example.id
}

# パブリックルートテーブル②
resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.example.id
}

# パブリックサブネット①とルートテーブル①の関連付け
resource "aws_route_table_association" "public_0" {
  subnet_id      = aws_subnet.public_0.id
  route_table_id = aws_route_table.public_0.id
}

# パブリックサブネット②とルートテーブル②の関連付け
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1.id
}

# パブリックルート①
resource "aws_route" "public_0" {
  route_table_id         = aws_route_table.public_0.id
  gateway_id             = aws_internet_gateway.example.id
  destination_cidr_block = "0.0.0.0/0"
}

# パブリックルート②
resource "aws_route" "public_1" {
  route_table_id         = aws_route_table.public_1.id
  gateway_id             = aws_internet_gateway.example.id
  destination_cidr_block = "0.0.0.0/0"
}
