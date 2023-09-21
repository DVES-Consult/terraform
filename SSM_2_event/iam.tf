resource "aws_iam_instance_profile" "EC2_access_for_SSM" {
  name = "EC2AccessForSSM"
  role = aws_iam_role.EC2_access_for_SSM.name
}

resource "aws_iam_role" "EC2_access_for_SSM" {
  name               = "EC2AccessForSSM"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = "Allows EC2 instances to call AWS services on your behalf."
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
  role       = aws_iam_role.EC2_access_for_SSM.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "EventBridge_Invoke_Run_Command" {
  name               = "Amazon_EventBridge_Invoke_Run_Command_522327604"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_event.json
  managed_policy_arns = ["arn:aws:iam::285552379206:policy/service-role/Amazon_EventBridge_Invoke_Run_Command_522327604"]
}


data "aws_iam_policy_document" "assume_role_event" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}