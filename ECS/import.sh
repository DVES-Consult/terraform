terraform import aws_ecs_cluster.teste teste4
terraform import aws_ecs_cluster_capacity_providers.teste teste4

terraform import aws_ecs_service.email_api teste4/api-email1
terraform import aws_ecs_task_definition.api_email arn:aws:ecs:us-east-1:285552379206:task-definition/api-email:2

terraform import aws_autoscaling_group.teste1 Infra-ECS-Cluster-teste4-901d6751-ECSAutoScalingGroup-1GK688CNE52A8
terraform import aws_launch_template.teste1 lt-0735dc1d16ad2c815