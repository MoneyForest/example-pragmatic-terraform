# VPC（仮想ネットワーク）
# こだわりがなければVPCではCIDRブロックは/16単位がおすすめ
# enable_dns_supportでAWSのDNSサーバーによる名前解決を有効にする
# enable_dns_hostnamesでVPCのリソースにパブリックDNSホスト名を自動的に割り当てる

resource "aws_vpc" "example" {
  cidr_block          = "10.0.0.0/16"
  enable_dns_support  = true
  enable_dns_hostnames = true

  tags = {
    Name = "example"
  }
}

# インターネットゲートウェイ
# VPCとインターネットを通信できるようにする
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}
