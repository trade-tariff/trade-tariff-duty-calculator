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

  execution_role_policy_arns = [
    aws_iam_policy.secrets.arn
  ]

  task_role_policy_arns = [
    aws_iam_policy.exec.arn,
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
      name  = "GOVUK_APP_DOMAIN"
      value = "${local.govuk_app_domain}.london.cloudapps.digital"
    },
    {
      name  = "GOVUK_WEBSITE_ROOT"
      value = "https://www.gov.uk"
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
    },
    {
      name  = "GOOGLE_TAG_MANAGER_CONTAINER_ID"
      value = var.google_tag_manager_container_id
    }
  ]

  service_secrets_config = [
    {
      name      = "NEW_RELIC_LICENSE_KEY"
      valueFrom = data.aws_secretsmanager_secret.new_relic_license_key.arn
    },
    {
      name      = "SECRET_KEY_BASE"
      valueFrom = data.aws_secretsmanager_secret.duty_calculator_secret_key_base.arn
    },
  ]
  enable_ecs_exec = true
}
