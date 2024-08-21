resource "aws_vpc" "harish_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.vpc-name}"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.harish_vpc.id
  cidr_block              = "10.0.0.0/19"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.harish_vpc.id
  cidr_block              = "10.0.32.0/19"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id     = aws_vpc.harish_vpc.id
  cidr_block = "10.0.64.0/19"

  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id     = aws_vpc.harish_vpc.id
  cidr_block = "10.0.96.0/19"

  tags = {
    Name = "private-subnet-1b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.harish_vpc.id

  tags = {
    Name = "${var.vpc-name}-igw"
  }
}

resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "harish_vpc_NAT" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public_subnet_1a.id

  tags = {
    Name = "${var.vpc-name}-NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.harish_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc-name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_ass" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_ass2" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.harish_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.harish_vpc_NAT.id
  }

  tags = {
    Name = "${var.vpc-name}-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_ass" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_rt_ass2" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_rt.id
}







