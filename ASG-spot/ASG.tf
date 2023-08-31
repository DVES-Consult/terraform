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

resource "aws_autoscaling_group" "site_web1" {
  name               = "site-web1"
  availability_zones = [ "us-east-1c", "us-east-1a", "us-east-1b"]
  desired_capacity   = 2
  capacity_rebalance = true
  desired_capacity_type = "units"
  max_size           = 3
  min_size           = 1

  mixed_instances_policy {
    instances_distribution {
      on_demand_allocation_strategy            = "lowest-price"
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 15
      spot_allocation_strategy                 = "price-capacity-optimized"
      spot_instance_pools                      = 0
    }
    launch_template {
      launch_template_specification {
        launch_template_id   = aws_launch_template.site_web.id
        launch_template_name = aws_launch_template.site_web.name
        version              = "$Latest"
      }
      override {
        instance_type = "t2.nano"
      }
      override {
        instance_type = "t2.micro"
      }
    }
  }
  # launch_template {
  #   id      = aws_launch_template.site_web.id
  #   version = "$Latest"
  # }
}

resource "aws_autoscaling_attachment" "site_web1" {
  autoscaling_group_name = aws_autoscaling_group.site_web1.id
  lb_target_group_arn    = aws_lb_target_group.site_web_1.arn
}
