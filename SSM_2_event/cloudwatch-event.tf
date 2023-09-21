resource "aws_cloudwatch_event_rule" "teste" {
  name        = "teste"
  event_pattern = templatefile("${path.module}/documents/event-pattern.json", {
    "autoscaling_name": "${aws_autoscaling_group.teste.name}"
   })
}

data "aws_instances" "test" {
  instance_tags = {
    Environment = "Development"
  }

  instance_state_names = ["running"]
}

resource "aws_cloudwatch_event_target" "teste" {
  rule      = aws_cloudwatch_event_rule.teste.name
  role_arn = "arn:aws:iam::285552379206:role/service-role/Amazon_EventBridge_Invoke_Run_Command_522327604"
  arn       = aws_ssm_document.test_ssm.arn

  run_command_targets {
    key = "tag:Launch_template_version"
    values = ["${aws_launch_template.teste.latest_version - 1 }"]
  }

  # run_command_targets {
  #   key    = "InstanceIds"
  #   values = data.aws_instances.test.ids
  # }
}


# run_command_targets {
#     key = "tag:Environment"
#     values = ["${aws_launch_template.teste.latest_version - 1 }"]
#   }