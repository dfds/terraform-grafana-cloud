locals {
  sm_access_policy_name = "${var.route53_record_name}-metric-publisher-for-sm"
}

resource "grafana_cloud_access_policy" "this" {
  count    = var.install_synthetic_monitoring ? 1 : 0
  provider = grafana.cloud

  region = grafana_cloud_stack.this.region_slug
  name   = local.sm_access_policy_name
  scopes = ["metrics:write", "stacks:read", "logs:write", "traces:write"]
  realm {
    type       = "stack"
    identifier = grafana_cloud_stack.this.id
  }
}

resource "grafana_cloud_access_policy_token" "this" {
  count    = var.install_synthetic_monitoring ? 1 : 0
  provider = grafana.cloud

  region           = grafana_cloud_stack.this.region_slug
  access_policy_id = grafana_cloud_access_policy.this[0].policy_id
  name             = local.sm_access_policy_name
}

resource "grafana_synthetic_monitoring_installation" "this" {
  count    = var.install_synthetic_monitoring ? 1 : 0
  provider = grafana.cloud

  stack_id              = grafana_cloud_stack.this.id
  metrics_publisher_key = grafana_cloud_access_policy_token.this[0].token
}

resource "aws_ssm_parameter" "sm_access_token" {
  count    = var.install_synthetic_monitoring ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.route53_record_name}/sm-access-token"
  type  = "SecureString"
  value = grafana_synthetic_monitoring_installation.this[0].sm_access_token
}

resource "aws_ssm_parameter" "sm_api_url" {
  count    = var.install_synthetic_monitoring ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.route53_record_name}/sm-api-url"
  type  = "String"
  value = grafana_synthetic_monitoring_installation.this[0].stack_sm_api_url
}
