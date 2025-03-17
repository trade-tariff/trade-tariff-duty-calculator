module "service" {
  source = "git@github.com:trade-tariff/trade-tariff-platform-terraform-modules.git//aws/ecs-service?ref=aws/ecs-service-v1.13.0"

  region = var.region

  service_name  = "duty-calculator"
  service_count = var.service_count

  cluster_name              = "trade-tariff-cluster-${var.environment}"
  subnet_ids                = data.aws_subnets.private.ids
  security_groups           = [data.aws_security_group.this.id]
  target_group_arn          = data.aws_lb_target_group.this.arn
  cloudwatch_log_group_name = "platform-logs-${var.environment}"

  min_capacity = var.min_capacity
  max_capacity = var.max_capacity

  docker_image = "382373577178.dkr.ecr.eu-west-2.amazonaws.com/tariff-duty-calculator-production"
  docker_tag   = var.docker_tag
  skip_destroy = true

  container_port = 8080

  cpu    = var.cpu
  memory = var.memory

  execution_role_policy_arns = [aws_iam_policy.exec.arn]
  task_role_policy_arns      = [aws_iam_policy.task.arn]
  enable_ecs_exec            = true

  service_environment_config = local.secret_env_vars
}

locals {
  secret_value = try(data.aws_secretsmanager_secret_version.this.secret_string, "{}")
  secret_map   = jsondecode(local.secret_value)
  secret_env_vars = [
    for key, value in local.secret_map : {
      name      = key
      valueFrom = value
    }
  ]
}
