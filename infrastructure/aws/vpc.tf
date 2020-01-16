#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "eks_cluster_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = map(
      "Name", "${var.prefix}-eks-node",
      "kubernetes.io/cluster/${var.prefix}-eks-cluster", "shared",
  )
}

resource "aws_subnet" "eks_cluster_subnet" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.eks_cluster_vpc.id

  tags = map(
      "Name", "${var.prefix}-eks-node",
      "kubernetes.io/cluster/${var.prefix}-eks-cluster", "shared",
  )
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.eks_cluster_vpc.id

  tags = {
    Name = "${var.prefix}-eks-internet-gateways"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.eks_cluster_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "route_table_association" {
  count = 2

  subnet_id      = aws_subnet.eks_cluster_subnet.*.id[count.index]
  route_table_id = aws_route_table.route_table.id
}
