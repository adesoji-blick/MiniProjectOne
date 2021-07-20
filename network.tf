# VPC, Subnets, IGW, Routing Table & Subnet Association Creation #

# VPC Creation #
resource "aws_vpc" "training_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "training_vpc"
  }
}

# Subnet Creation #
resource "aws_subnet" "training_subnet" {
  count                   = var.instance_count
  vpc_id                  = aws_vpc.training_vpc.id
  cidr_block              = var.subnet_cidr_block[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet_${count.index + 1}"
  }
}

# Internet Gateway Creation # 
resource "aws_internet_gateway" "training_igw" {
  vpc_id = aws_vpc.training_vpc.id

  tags = {
    Name = "public_igw"
  }
}

# Route Table Creation # 
resource "aws_route_table" "training_rt" {
  vpc_id = aws_vpc.training_vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.training_igw.id
  }

  tags = {
    Name = "training_rt"
  }
}

# Route Table Association # 
resource "aws_route_table_association" "training_rt" {
  count          = var.instance_count
  subnet_id      = aws_subnet.training_subnet[count.index].id
  route_table_id = aws_route_table.training_rt.id
}
