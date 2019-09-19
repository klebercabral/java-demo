resource "aws_vpc" "java-tf" {
  cidr_block           = "10.13.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "java-terraform"
  }
}

resource "aws_subnet" "java-public-1" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "10.13.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "java-public-1"
  }
}

resource "aws_subnet" "java-public-2" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "10.13.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "java-public-2"
  }
}

resource "aws_subnet" "java-public-3" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "10.13.30.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "java-public-3"
  }
}

resource "aws_subnet" "java-private-1" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "10.13.40.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "java-private-1"
  }
}

resource "aws_subnet" "java-private-2" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "10.13.50.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "java-private-2"
  }
}

resource "aws_subnet" "java-private-3" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "10.13.60.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "java-private-3"
  }
}

resource "aws_internet_gateway" "java-gw" {
  vpc_id = aws_vpc.java-tf.id

  tags = {
    Name = "java-IG"
  }
}

resource "aws_route_table" "java-public" {
  vpc_id = aws_vpc.java-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.java-gw.id
  }

  tags = {
    Name = "java-public-1"
  }
}

resource "aws_route_table_association" "java-public-1-a" {
  subnet_id      = aws_subnet.java-public-1.id
  route_table_id = aws_route_table.java-public.id
}

resource "aws_route_table_association" "java-public-2-a" {
  subnet_id      = aws_subnet.java-public-2.id
  route_table_id = aws_route_table.java-public.id
}

resource "aws_route_table_association" "java-public-3-a" {
  subnet_id      = aws_subnet.java-public-3.id
  route_table_id = aws_route_table.java-public.id
}
