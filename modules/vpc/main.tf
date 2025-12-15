resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = { Name = var.vpc_name }
}

# Public Subnets
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1" }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-2" }
}

resource "aws_subnet" "public_3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = var.az3
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-3" }
}

# Private Subnets
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = var.az1
  tags = { Name = "private-subnet-1" }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = var.az2
  tags = { Name = "private-subnet-2" }
}

resource "aws_subnet" "private_3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet3_cidr
  availability_zone = var.az3
  tags = { Name = "private-subnet-3" }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associations
resource "aws_route_table_association" "public_assocs" {
  for_each = {
    "1" = aws_subnet.public_1.id
    "2" = aws_subnet.public_2.id
    "3" = aws_subnet.public_3.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# NAT + EIP
resource "aws_eip" "nat_eip" { vpc = true }

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

# Private Associations
resource "aws_route_table_association" "private_assocs" {
  for_each = {
    "1" = aws_subnet.private_1.id
    "2" = aws_subnet.private_2.id
    "3" = aws_subnet.private_3.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
