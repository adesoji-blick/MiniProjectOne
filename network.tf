resource "aws_vpc" "training_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "training"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.training_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet_1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.training_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet_2"
  }
}

resource "aws_subnet" "subnet_3" {
  vpc_id            = aws_vpc.training_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ca-central-1a"

  tags = {
    Name = "subnet_3"
  }
}

resource "aws_internet_gateway" "training-igw" {
  vpc_id = aws_vpc.training_vpc.id

  tags = {
    Name = "public_igw"
  }
}

resource "aws_route_table" "training_rt" {
  vpc_id = aws_vpc.training_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.training-igw.id
  }

  tags = {
    Name = "training_rt"
  }
}

resource "aws_route_table_association" "training_rt_ass_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.training_rt.id
}

resource "aws_route_table_association" "training_rt_ass_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.training_rt.id
}

resource "aws_route_table_association" "training_rt_ass_3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.training_rt.id
} 