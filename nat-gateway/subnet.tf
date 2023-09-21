resource "aws_subnet" "pub_subnet_b" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone = "us-east-1b"
    cidr_block              = "10.0.0.0/28"
    map_public_ip_on_launch                        = true
    tags = {
      Name = "pub-subnet-b"
    }
}

resource "aws_subnet" "pub_subnet_c" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone = "us-east-1c"
    cidr_block              = "10.0.0.16/28"
    map_public_ip_on_launch                        = true
    tags = {
      Name = "pub-subnet-c"
    }
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone = "us-east-1b"
    cidr_block              = "10.0.0.32/28"
    map_public_ip_on_launch = false
    tags = {
      Name = "private-subnet-b"
    }
}

resource "aws_subnet" "private_subnet_c" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone = "us-east-1c"
    cidr_block              = "10.0.0.48/28"
    map_public_ip_on_launch = false
    tags = {
      Name = "private-subnet-c"
    }
}

resource "aws_subnet" "db_subnet_b" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone = "us-east-1b"
    cidr_block              = "10.0.0.64/28"
    map_public_ip_on_launch = false
    tags = {
      Name = "db-subnet-b"
    }
}

resource "aws_subnet" "db_subnet_c" {
    vpc_id                  = aws_vpc.vpc.id
    availability_zone = "us-east-1c"
    cidr_block              = "10.0.0.80/28"
    map_public_ip_on_launch = false
    tags = {
      Name = "db-subnet-c"
    }
}