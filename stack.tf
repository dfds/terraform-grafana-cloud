locals {
  service_account_name = "${var.slug}-terraform-sa
  stack_name = var.hosted_zone_name != null ? aws_route53_record.this[0].fqdn : var.stack_name
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

resource "grafana_cloud_plugin_installation" "this" {
  for_each = var.plugins
  stack_slug = local.stack_name
  slug       = each.value.plugin
  version    = each.value.version
}
