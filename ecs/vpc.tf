#Criar nova VPC

resource "aws_vpc" "java-tf" {
  cidr_block           = "172.21.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "java-terraform"
  }
}

#Criar subnet publica

resource "aws_subnet" "java-public-1" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "172.21.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "java-public-1"
  }
}

#Criar subnet publica

resource "aws_subnet" "java-public-2" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "172.21.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "java-public-2"
  }
}

#Criar subnet publica

resource "aws_subnet" "java-public-3" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "172.21.30.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "java-public-3"
  }
}

#Criar subnet privada

resource "aws_subnet" "java-private-1" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "172.21.40.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "java-private-1"
  }
}

#Criar subnet privada

resource "aws_subnet" "java-private-2" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "172.21.50.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "java-private-2"
  }
}

#Criar subnet privada

resource "aws_subnet" "java-private-3" {
  vpc_id                  = aws_vpc.java-tf.id
  cidr_block              = "172.21.60.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "java-private-3"
  }
}

#Criar IGW

resource "aws_internet_gateway" "java-gw" {
  vpc_id = aws_vpc.java-tf.id

  tags = {
    Name = "java-IG"
  }
}

#Criar rota para IGW

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

#Associar rota

resource "aws_route_table_association" "java-public-1-a" {
  subnet_id      = aws_subnet.java-public-1.id
  route_table_id = aws_route_table.java-public.id
}

#Associar rota

resource "aws_route_table_association" "java-public-2-a" {
  subnet_id      = aws_subnet.java-public-2.id
  route_table_id = aws_route_table.java-public.id
}

#Associar rota

resource "aws_route_table_association" "java-public-3-a" {
  subnet_id      = aws_subnet.java-public-3.id
  route_table_id = aws_route_table.java-public.id
}
