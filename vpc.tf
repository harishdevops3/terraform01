resource "aws_vpc" "harish_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "harish-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.harish_vpc.id
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${data.aws_availability_zones.zones.names[count.index]}"
  }

}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.harish_vpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.zones.names[count.index]

  tags = {
    Name = "private-subnet-${data.aws_availability_zones.zones.names[count.index]}"
  }
}

resource "aws_subnet" "database_subnet" {
  count             = length(var.database_subnet_cidr)
  vpc_id            = aws_vpc.harish_vpc.id
  cidr_block        = element(var.database_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.zones.names[count.index]

  tags = {
    Name = "database-subnet-${data.aws_availability_zones.zones.names[count.index]}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.harish_vpc.id

  tags = {
    Name = "harish-vpc-igw"
  }
}

resource "aws_eip" "private_elastic_ip" {
  domain = "vpc"
}
resource "aws_eip" "database_elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "harish_vpc_private_NAT" {
  allocation_id = aws_eip.private_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "harish-vpc-private-NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "harish_vpc_database_NAT" {
  allocation_id = aws_eip.database_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "harish-vpc-database-NAT"
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
    Name = "public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.harish_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.harish_vpc_private_NAT.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.harish_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.harish_vpc_database_NAT.id
}

  tags = {
    Name = "database-rt"
  }
}


resource "aws_route_table_association" "public_rt_ass" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_ass" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "database_rt_ass" {
  count          = length(var.database_subnet_cidr)
  subnet_id      = aws_subnet.database_subnet[count.index].id
  route_table_id = aws_route_table.database_rt.id
}
