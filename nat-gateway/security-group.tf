resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.66.243.186/32"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["45.189.97.196/32"]
  }

  ingress {
    description = ""
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["45.189.96.198/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ssh"
  }
}

# resource "aws_security_group" "load_balancer" {
#   name        = "load_balancer"
#   description = "Allow TLS inbound traffic"

#   ingress {

#     description = "TLS from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {

#     description = "TLS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "load_balancer"
#   }
# }

# resource "aws_security_group" "server_ec2" {
#   name        = "server-ec2"
#   description = "Allow TLS inbound traffic"

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["172.31.0.0/16"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["177.66.243.186/32"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["45.189.97.196/32"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["45.189.96.207/32"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "server-ec2"
#   }
# }

resource "aws_security_group" "server_HTTP" {
  name        = "server-HTTP"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["177.66.243.186/32"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["45.189.96.207/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "server-ec2"
  }
}

resource "aws_security_group" "db_sql" {
  name        = "db-sql"
  
  ingress {
    description      = "private-subnet-b"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.32/28",]
  }

  ingress {
    description      = "private-subnet-c"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.48/28"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "db-sql"
  }
}

# resource "aws_security_group" "cluster" {
#   name        = "cluster"
#   description = "Allow TLS inbound traffic"

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["172.31.0.0/16"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["172.31.0.0/16"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["177.66.243.186/32"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["45.189.97.196/32"]
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["45.189.96.207/32"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "server-ec2"
#   }
# }