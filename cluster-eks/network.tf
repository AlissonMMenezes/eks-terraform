resource "aws_vpc" "eksvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.eksvpc.id
}

resource "aws_eip" "nat1" {
  vpc = true
}

resource "aws_nat_gateway" "natgw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.eks-public-subnet.id
  depends_on    = [aws_internet_gateway.gw]
}


resource "aws_subnet" "eks-public-subnet" {
#   map_public_ip_on_launch = true
  availability_zone   = "us-east-1a"
  cidr_block          = "10.0.0.0/24"
  vpc_id              = aws_vpc.eksvpc.id
  tags = tomap({
    "kubernetes.io/cluster/4LinuxCluster" = "shared"
    "kubernetes.io/role/elb"              = 1
  })

}

resource "aws_subnet" "eks-private-subnet-1" {
  availability_zone   = "us-east-1b"
  cidr_block          = "10.0.1.0/24"
  vpc_id              = aws_vpc.eksvpc.id
  tags = tomap({
    "kubernetes.io/cluster/4LinuxCluster" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  })
}



resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.eksvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw1.id
  }
  
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.eksvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
}

resource "aws_route_table_association" "route-public" {
  subnet_id      = aws_subnet.eks-public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "route-private" {
  subnet_id      = aws_subnet.eks-private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}