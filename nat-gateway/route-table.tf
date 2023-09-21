resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_b.id
  }

  tags = {
    Name        = "private-route-table-b"
  }
}

resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_c.id
  }

  tags = {
    Name        = "private-route-table-c"
  }
}

resource "aws_route_table" "db_private_b" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "db-private-route-table-b"
  }
}

resource "aws_route_table" "db_private_c" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "db-private-route-table-c"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name        = "public-route-table"
  }
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_c.id
}

resource "aws_route_table_association" "db_private_b" {
  subnet_id      = aws_subnet.db_subnet_b.id
  route_table_id = aws_route_table.db_private_b.id
}

resource "aws_route_table_association" "db_private_c" {
  subnet_id      = aws_subnet.db_subnet_c.id
  route_table_id = aws_route_table.db_private_c.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.pub_subnet_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.pub_subnet_c.id
  route_table_id = aws_route_table.public.id
}