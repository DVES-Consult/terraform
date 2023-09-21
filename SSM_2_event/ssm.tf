resource "aws_ssm_document" "test_ssm" {
  name            = "test-document"
  document_format = "YAML"
  document_type   = "Command"

  content = file("${path.module}/documents/test-document.yml")

}

# resource "time_sleep" "wait" {
#   create_duration = "15s"
# }

# resource "aws_ssm_association" "teste_ssm" {
#   name = aws_ssm_document.test_ssm.name
#   targets {
#     key    = "tag:Environment"
#     values = ["Development"]
#   }

#   lifecycle {
#     replace_triggered_by = [ aws_launch_template.teste.latest_version ]
#   }
# }
