resource "aws_instance" "teste_ssm" {
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "teste-ec2"
  tags                                 = {
    "Name" = "teste-ssm"
  }
  iam_instance_profile = aws_iam_instance_profile.EC2_access_for_SSM.name
  subnet_id = aws_subnet.pub_subnet_b.id
  vpc_security_group_ids = [ aws_security_group.ssh.id]
}

resource "aws_instance" "teste" {
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "teste-ec2"
  associate_public_ip_address = false
  tags                                 = {
    "Name" = "teste"
  }
  iam_instance_profile = aws_iam_instance_profile.EC2_access_for_SSM.name
  subnet_id = aws_subnet.private_subnet_b.id
  vpc_security_group_ids = [ aws_security_group.ssh.id, aws_security_group.server_HTTP.id]
}
