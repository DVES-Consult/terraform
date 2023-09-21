resource "aws_autoscaling_group" "teste" {
  name                      = "EC2ContainerService-teste5-EcsInstanceAsg-1U1F2VFV7110C"
  max_size                  = 2
  desired_capacity          = 2
  min_size                  = 0
  health_check_grace_period = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-041421edbf1981cb9"]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 20
    }
  }

  launch_template {
    id      = aws_launch_template.teste.id
    version = aws_launch_template.teste.latest_version
  }

  
  tag {
    key                 = "Launch_template_version"
    propagate_at_launch = true
    value               = "${aws_launch_template.teste.latest_version}"
  }

}

resource "aws_autoscaling_lifecycle_hook" "teste" {
  name                   = "my-lifecycle-hook"
  autoscaling_group_name = aws_autoscaling_group.teste.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = 40
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
}

locals {
  ami = "ami-0f34c5ae932e6f0e4"
}

resource "aws_launch_template" "teste" {
  name                    = "teste"
  disable_api_stop        = false
  disable_api_termination = false
  image_id                = local.ami
  instance_type           = "t2.micro"
  key_name                = "teste-ec2"

  iam_instance_profile {
    arn = aws_iam_instance_profile.EC2_access_for_SSM.arn
  }

  monitoring {
    enabled = false
  }

  network_interfaces {
    subnet_id       = "subnet-041421edbf1981cb9"
    security_groups = [aws_security_group.server_ec2.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Environment" = "Development"
      "batata" = "sddds"
      
    }
  }
}
