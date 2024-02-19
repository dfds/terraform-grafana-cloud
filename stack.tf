locals {
  service_account_name = "${var.slug}-terraform-sa"
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

resource "grafana_cloud_plugin_installation" "this" {
  for_each = { for x in var.plugins : x.plugin => x }
  provider = grafana.cloud

  stack_slug = grafana_cloud_stack.this.slug
  slug       = each.value.plugin
  version    = each.value.version
}
