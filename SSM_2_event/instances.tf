# resource "aws_instance" "teste_ssm" {
#   ami           = "ami-0f34c5ae932e6f0e4"
#   instance_type = "t2.micro"
#   tags = {
#     "Name"        = "teste-ssm"
#     "Environment" = "Development"
#   }
#   security_groups      = ["launch-wizard-1"]
#   iam_instance_profile = aws_iam_instance_profile.EC2_access_for_SSM.name
# }
