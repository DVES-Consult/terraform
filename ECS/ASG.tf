resource "aws_autoscaling_group" "teste1" {
  name                      = "Infra-ECS-Cluster-teste4-901d6751-ECSAutoScalingGroup-1GK688CNE52A8"
  max_size                  = 5
  desired_capacity          = 2
  min_size                  = 2
  health_check_grace_period = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-041421edbf1981cb9", "subnet-00700a743464535ce"]

  launch_template {
    id      = aws_launch_template.teste1.id
    version = aws_launch_template.teste1.latest_version
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

resource "aws_launch_template" "teste1" {
  name = "ECSLaunchTemplate_8f36Kc1xsrog"
  disable_api_stop        = false
  disable_api_termination = false
  image_id = "ami-0e692fe1bae5ca24c"
  instance_type = "t2.micro"
  key_name = "teste-ec2"

  iam_instance_profile {
    arn = "arn:aws:iam::285552379206:instance-profile/ecsInstanceRole" 
  }
 

  user_data = filebase64("${path.module}/teste.sh")
}
