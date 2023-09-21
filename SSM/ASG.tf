resource "aws_autoscaling_group" "teste" {
  name                      = "EC2ContainerService-teste5-EcsInstanceAsg-1U1F2VFV7110C"
  max_size                  = 1
  desired_capacity          = 1
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
   key                 = "Description"
   propagate_at_launch = true
   value               = "This instance is the part of the Auto Scaling group which was created through ECS Console"
  }
  tag {
   key                 = "Name"
   propagate_at_launch = true
   value               = "ECS Instance - EC2ContainerService-teste5"
  }

}

resource "aws_launch_template" "teste" {
  name = "teste"
  disable_api_stop        = false
  disable_api_termination = false
  image_id = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name = "teste-ec2"

  iam_instance_profile {
    arn = aws_iam_instance_profile.EC2_access_for_SSM.arn 
  }

  monitoring {
    enabled = false 
  }

  network_interfaces {
    subnet_id          = "subnet-041421edbf1981cb9"
    security_groups    = [aws_security_group.server_ec2.id]
  }  
}
