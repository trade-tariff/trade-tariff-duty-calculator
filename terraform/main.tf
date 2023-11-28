module "service" {
  source = "git@github.com:trade-tariff/trade-tariff-platform-terraform-modules.git//aws/ecs-service?ref=aws/ecs-service-v1.11.3"

  region = var.region

  service_name  = local.service
  service_count = var.service_count

  cluster_name              = "trade-tariff-cluster-${var.environment}"
  subnet_ids                = data.aws_subnets.private.ids
  security_groups           = [data.aws_security_group.this.id]
  target_group_arn          = data.aws_lb_target_group.this.arn
  cloudwatch_log_group_name = "platform-logs-${var.environment}"

  min_capacity = var.min_capacity
  max_capacity = var.max_capacity

  docker_image = data.aws_ssm_parameter.ecr_url.value
  docker_tag   = var.docker_tag
  skip_destroy = true

  container_port = 8080

  cpu    = var.cpu
  memory = var.memory

  execution_role_policy_arns = [
    aws_iam_policy.secrets.arn
  ]

  service_environment_config = [
    {
      name  = "PORT"
      value = "8080"
    },
    {
      name  = "API_SERVICE_BACKEND_URL_OPTIONS"
      value = jsonencode(local.api_service_backend_url_options)
    },
    {
      name  = "DUTY_CALCULATOR_EXCISE_STEP_ENABLED"
      value = "true"
    },
    {
      name  = "NEW_RELIC_APP_NAME"
      value = "tariff-${local.service}-${var.environment}"
    },
    {
      name  = "NEW_RELIC_ENV"
      value = var.environment
    },
    {
      name  = "NEW_RELIG_LOG"
      value = "stdout"
    },
    {
      name  = "NEW_RELIC_DISTRIBUTED_TRACING"
      value = "false"
    },
    {
      name  = "RAILS_ENV"
      value = "production"
    },
    {
      name  = "RAILS_SERVE_STATIC_FILES"
      value = "true"
    },
    {
      name  = "RUBYOPT"
      value = "--enable-yjit"
    },
    {
      name  = "TRADE_TARIFF_FRONTEND_URL"
      value = "https://${var.base_domain}"
    }
  ]

  service_secrets_config = [
    {
      name      = "SECRET_KEY_BASE"
      valueFrom = data.aws_secretsmanager_secret.duty_calculator_secret_key_base.arn
    },
    {
      name      = "SENTRY_DSN"
      valueFrom = data.aws_secretsmanager_secret.sentry_dsn.arn
    },
  ]
}
