locals {
  service_account_name = "terraform-sa"
  otlp_name            = "${var.route53_record_name}-otlp-access"
}

resource "grafana_cloud_stack" "this" {
  provider = grafana.cloud

  name        = var.hosted_zone_name != null ? aws_route53_record.this[0].fqdn : var.stack_name
  slug        = var.slug
  region_slug = var.region_slug
  description = var.stack_description
  url         = var.hosted_zone_name != null ? "https://${aws_route53_record.this[0].fqdn}" : var.url
}

resource "grafana_cloud_stack_service_account" "this" {
  provider = grafana.cloud
  stack_slug = grafana_cloud_stack.this.slug

  name        = local.service_account_name
  role        = "Admin"
  is_disabled = false
}

resource "grafana_cloud_stack_service_account_token" "this" {
  provider = grafana.cloud
  stack_slug = grafana_cloud_stack.this.slug

  name               = "${local.service_account_name}-key"
  service_account_id = grafana_cloud_stack_service_account.this.id
}

resource "aws_ssm_parameter" "grafana_cloud_stack_service_account_token" {
  provider = aws.route53

  name  = "/grafana-cloud/${var.route53_record_name}/${local.service_account_name}-access-token"
  type  = "SecureString"
  value = grafana_cloud_stack_service_account_token.this.key
}

resource "aws_ssm_parameter" "grafana_cloud_stack_url" {
  provider = aws.route53

  name  = "/grafana-cloud/${var.route53_record_name}/stack-url"
  type  = "String"
  value = grafana_cloud_stack.this.url
}

resource "grafana_cloud_plugin_installation" "this" {
  for_each = { for x in var.plugins : x.plugin => x }
  provider = grafana.cloud

  stack_slug = grafana_cloud_stack.this.slug
  slug       = each.value.plugin
  version    = each.value.version
}

resource "grafana_cloud_access_policy" "otlp" {
  count = var.enable_otlp ? 1 : 0
  provider = grafana.cloud

  region = grafana_cloud_stack.this.region_slug
  name   = local.otlp_name
  scopes = ["metrics:write", "metrics:import", "logs:write", "traces:write", "alerts:write", "rules:write", "profiles:write"]
  realm {
    type       = "stack"
    identifier = grafana_cloud_stack.this.id
  }
}

resource "grafana_cloud_access_policy_token" "otlp" {
  count = var.enable_otlp ? 1 : 0
  provider = grafana.cloud

  region           = grafana_cloud_stack.this.region_slug
  access_policy_id = grafana_cloud_access_policy.otlp[0].policy_id
  name             = local.otlp_name
}

resource "aws_ssm_parameter" "otlp_access_token" {
  count = var.enable_otlp ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.route53_record_name}/otlp-access-token"
  type  = "SecureString"
  value = grafana_cloud_access_policy_token.otlp[0].token
}
