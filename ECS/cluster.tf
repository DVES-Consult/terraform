resource "aws_ecs_cluster" "teste" {
  name = "teste4"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  service_connect_defaults {
    namespace = "arn:aws:servicediscovery:us-east-1:285552379206:namespace/ns-lstfcw3iitcw3ft3"
  }
}


resource "aws_ecs_cluster_capacity_providers" "teste" {
  cluster_name = aws_ecs_cluster.teste.name

  capacity_providers = ["Infra-ECS-Cluster-teste4-901d6751-EC2CapacityProvider-jC2Sz5vlquXj"]

  default_capacity_provider_strategy {
    base = 0
    capacity_provider = "Infra-ECS-Cluster-teste4-901d6751-EC2CapacityProvider-jC2Sz5vlquXj"
    weight = 1
  }

}

resource "aws_ecs_service" "email_api" {
  name                    = "api-email1"
  cluster                 = aws_ecs_cluster.teste.id
  task_definition         = "api-email:16"
  desired_count           = 1
  enable_ecs_managed_tags = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_enviar_email_1.arn
    container_name   = "api-email"
    container_port   = 3000
  }

  capacity_provider_strategy {
    base              = 0
    capacity_provider = "Infra-ECS-Cluster-teste4-901d6751-EC2CapacityProvider-jC2Sz5vlquXj"
    weight            = 1
  }

  deployment_controller {
    type = "ECS"
  }
  ordered_placement_strategy {
         field = "attribute:ecs.availability-zone" 
         type  = "spread" 
        }
     ordered_placement_strategy {
         field = "instanceId" 
         type  = "spread" 
        }

}

resource "aws_ecs_service" "site1" {
  name                    = "site"
  health_check_grace_period_seconds  = 5
  cluster                 = aws_ecs_cluster.teste.id
  task_definition         = "site:9"
  desired_count           = 1
  enable_ecs_managed_tags = false

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.site_web_1.arn
    container_name   = "site"
    container_port   = 80
  }

  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.server_HTTP.id,
    ]
    subnets = [
      "subnet-041421edbf1981cb9"
    ]
  }

  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone" 
    type  = "spread" 
  }
  ordered_placement_strategy {
    field = "instanceId" 
    type  = "spread" 
  }

}

