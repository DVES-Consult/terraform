data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecsInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecsInstanceRole"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_instance_profile" "EC2_access_for_SSM" {
  name = "EC2AccessForSSM"
  role = aws_iam_role.EC2_access_for_SSM.name
}

resource "aws_iam_role" "EC2_access_for_SSM" {
  name               = "EC2AccessForSSM"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description           = "Allows EC2 instances to call AWS services on your behalf."
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "EC2_access_for_SSM_policy" { 
role = aws_iam_role.EC2_access_for_SSM.name 
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" 
}

