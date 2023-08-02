resource "aws_launch_template" "site_web" {
  name = "site-web"
  disable_api_stop        = false
  disable_api_termination = false
  image_id = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "teste-ec2"

  network_interfaces {
    security_groups = [ aws_security_group.server_HTTP.id, aws_security_group.ssh.id ]
    subnet_id = "subnet-041421edbf1981cb9"
  }  

  user_data = filebase64("${path.module}/scripts-front.sh")
}

resource "aws_launch_template" "api_node" {
  name = "api-node"
  disable_api_stop        = false
  disable_api_termination = false
  image_id = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "teste-ec2"

  network_interfaces {
    security_groups = [ aws_security_group.server_ec2.id, aws_security_group.ssh.id ]
    subnet_id = "subnet-041421edbf1981cb9"
  }  

  user_data = filebase64("${path.module}/scripts-back.sh")
}

resource "aws_autoscaling_group" "site_web1" {
  name               = "site-web1"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.site_web.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "api_enviar_email" {
  name               = "api-enviar-email"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2

  launch_template {
    id      = aws_launch_template.api_node.id
    version = "$Latest"
  }
}

# resource "aws_autoscaling_attachment" "site_web1" {
#   autoscaling_group_name = aws_autoscaling_group.site_web1.id
#   lb_target_group_arn    = aws_lb_target_group.site_web_1.arn
# }
