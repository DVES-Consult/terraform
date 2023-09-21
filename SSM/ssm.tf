resource "aws_ssm_document" "test_ssm" {
  name            = "test-document"
  document_format = "YAML"
  document_type   = "Command"

  content = file("${path.module}/documents/test-document.yml")
}

resource "aws_ssm_association" "teste_ssm" {
  name = aws_ssm_document.test_ssm.name

  targets {
    key    = "tag:Environment"
    values = ["Development"]
  }
}

resource "aws_ssm_maintenance_window" "teste" {
  name     = "teste"
  # schedule = "rate(2 minutes)"
  schedule = "cron(0/2 * * * ? *)"
  duration = 2
  cutoff   = 1
  # allow_unassociated_targets = true
}

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id     = aws_ssm_maintenance_window.teste.id
  name          = "maintenance-window-target"
  description   = "This is a maintenance window target"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Environment"
    values = ["Development"]
  }
}

resource "aws_ssm_maintenance_window_task" "example2" {
  max_concurrency = 1
  max_errors      = 2
  priority        = 1
  #arn
  task_arn        = aws_ssm_document.test_ssm.arn
  task_type       = "RUN_COMMAND"
  window_id       = aws_ssm_maintenance_window.teste.id

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.target1.id]
  }

  task_invocation_parameters { 
    run_command_parameters { 
      document_version = "$LATEST"
      timeout_seconds   =  600 
    } 
  } 
}
