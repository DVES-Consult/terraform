resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags       = {
        Name = "Terraform VPC"
    }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "nat_eip_b" {
  domain   = "vpc"
}

resource "aws_eip" "nat_eip_c" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_b" {
    allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.pub_subnet_b.id
  tags = {
    Name        = "nat-b"
  }
}

resource "aws_nat_gateway" "nat_c" {
  allocation_id = aws_eip.nat_eip_c.id
  subnet_id     = aws_subnet.pub_subnet_c.id
  tags = {
    Name        = "nat-c"
  }
}
