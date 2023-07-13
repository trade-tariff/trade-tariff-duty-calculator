data "aws_vpc" "vpc" {
  tags = { Name = "trade_tariff_${var.environment}_vpc" }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  tags = {
    Name = "*private*"
  }
}

data "aws_lb_target_group" "this" {
  name = "trade-tariff-fe-tg-${var.environment}"
}

data "aws_security_group" "this" {
  name = "trade-tariff-ecs-security-group-${var.environment}"
}

data "aws_secretsmanager_secret" "duty_calculator_secret_key_base" {
  name = "duty-calculator-secret-key-base"
}

data "aws_secretsmanager_secret" "newrelic_license_key" {
  name = "newrelic-license-key"
}

data "aws_kms_key" "secretsmanager_key" {
  key_id = "alias/secretsmanager-key"
}

data "aws_ssm_parameter" "ecr_url" {
  name = "/${var.environment}/DUTY_CALCULATOR_ECR_URL"
}
