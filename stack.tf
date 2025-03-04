locals {
  service_account_name        = "terraform-sa"
  service_account_editor_name = "sa-editor"
  otlp_name                   = "${var.slug}-otlp-access"
  read_only_name              = "${var.slug}-read-only-access"
  read_only_multi_stack       = "${var.slug}-read-only-multi-stack-access"
  write_only_name             = "${var.slug}-write-only-access"
  rules_management_name       = "${var.slug}-rules-management-access"
}

resource "grafana_cloud_stack" "this" {
  provider = grafana.cloud

  name        = var.hosted_zone_name != null ? aws_route53_record.this[0].fqdn : var.stack_name
  slug        = var.slug
  region_slug = var.region_slug
  description = var.stack_description
  url         = var.hosted_zone_name != null ? "https://${aws_route53_record.this[0].fqdn}" : var.url
  labels      = var.stack_labels
}

resource "grafana_cloud_stack_service_account" "this" {
  provider   = grafana.cloud
  stack_slug = grafana_cloud_stack.this.slug

  name        = local.service_account_name
  role        = "Admin"
  is_disabled = false
}

resource "grafana_cloud_stack_service_account_token" "this" {
  provider   = grafana.cloud
  stack_slug = grafana_cloud_stack.this.slug

  name               = "${local.service_account_name}-key"
  service_account_id = grafana_cloud_stack_service_account.this.id
}

resource "grafana_cloud_stack_service_account" "editor" {
  count      = length(var.service_account_editor_permissions) > 0 ? 1 : 0
  provider   = grafana.cloud
  stack_slug = grafana_cloud_stack.this.slug

  name        = local.service_account_editor_name
  role        = "Viewer"
  is_disabled = false
}

resource "grafana_cloud_stack_service_account_token" "editor" {
  count      = length(var.service_account_editor_permissions) > 0 ? 1 : 0
  provider   = grafana.cloud
  stack_slug = grafana_cloud_stack.this.slug

  name               = "${local.service_account_editor_name}-key"
  service_account_id = grafana_cloud_stack_service_account.editor[0].id
}

resource "grafana_role_assignment_item" "editor" {
  provider = grafana.stack
  for_each = toset(var.service_account_editor_permissions)

  role_uid           = data.grafana_role.this[each.value].uid
  service_account_id = trimprefix(grafana_cloud_stack_service_account.editor[0].id, "${var.slug}:")
}

resource "aws_ssm_parameter" "grafana_cloud_stack_service_account_token" {
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/${local.service_account_name}-access-token"
  type  = "SecureString"
  value = grafana_cloud_stack_service_account_token.this.key
}

resource "aws_ssm_parameter" "grafana_cloud_stack_url" {
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/stack-url"
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

resource "grafana_cloud_access_policy" "read_only" {
  count    = var.create_read_only_token ? 1 : 0
  provider = grafana.cloud

  region = grafana_cloud_stack.this.region_slug
  name   = local.read_only_name
  scopes = ["metrics:read", "logs:read", "traces:read", "profiles:read", "alerts:read", "rules:read"]
  realm {
    type       = "stack"
    identifier = grafana_cloud_stack.this.id
  }
}

resource "grafana_cloud_access_policy_token" "read_only" {
  count    = var.create_read_only_token ? 1 : 0
  provider = grafana.cloud

  region           = grafana_cloud_stack.this.region_slug
  access_policy_id = grafana_cloud_access_policy.read_only[0].policy_id
  name             = local.read_only_name
}

resource "aws_ssm_parameter" "read_only" {
  count    = var.create_read_only_token ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/read-only-access-token"
  type  = "SecureString"
  value = grafana_cloud_access_policy_token.read_only[0].token
}

data "grafana_cloud_stack" "this" {
  provider = grafana.cloud
  for_each = toset(var.stacks_for_multi_stack_querying)

  slug = each.value
}

resource "grafana_cloud_access_policy" "read_only_multi_stack" {
  count    = length(var.stacks_for_multi_stack_querying) > 0 ? 1 : 0
  provider = grafana.cloud

  region = grafana_cloud_stack.this.region_slug
  name   = local.read_only_multi_stack
  scopes = ["metrics:read", "logs:read", "traces:read", "profiles:read", "alerts:read", "rules:read"]

  dynamic "realm" {
    for_each = toset(var.stacks_for_multi_stack_querying)
    content {
      type       = "stack"
      identifier = data.grafana_cloud_stack.this[realm.value].id
    }
  }
}

resource "grafana_cloud_access_policy_token" "read_only_multi_stack" {
  count    = length(var.stacks_for_multi_stack_querying) > 0 ? 1 : 0
  provider = grafana.cloud

  region           = grafana_cloud_stack.this.region_slug
  access_policy_id = grafana_cloud_access_policy.read_only_multi_stack[0].policy_id
  name             = local.read_only_multi_stack
}

resource "aws_ssm_parameter" "read_only_multi_stack" {
  count    = length(var.stacks_for_multi_stack_querying) > 0 ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/read-only-multi-stack-access-token"
  type  = "SecureString"
  value = grafana_cloud_access_policy_token.read_only_multi_stack[0].token

  tags = var.tags
}

resource "grafana_team" "this" {
  provider = grafana.stack
  for_each = { for team in var.teams : team.name => team }

  name = each.value.name
  team_sync {
    groups = each.value.groups
  }
}

data "grafana_role" "this" {
  depends_on = [grafana_cloud_stack_service_account_token.this]
  provider   = grafana.stack
  for_each = toset(flatten([
    for team in var.teams : team.permissions
  ]))

  name = each.value
}

resource "grafana_role_assignment_item" "this" {
  provider = grafana.stack
  for_each = { for combination in flatten([
    for team in var.teams : [
      for permission in team.permissions : {
        key        = "${team.name}-${permission}",
        name       = team.name,
        permission = permission
      }
    ]
    ]) :
    combination.key => combination
  }

  role_uid = data.grafana_role.this[each.value.permission].uid
  team_id  = grafana_team.this[each.value.name].id
}

resource "grafana_cloud_access_policy" "write_only" {
  count    = var.create_write_only_token ? 1 : 0
  provider = grafana.cloud

  region = grafana_cloud_stack.this.region_slug
  name   = local.write_only_name
  scopes = ["metrics:write", "metrics:read", "metrics:import", "logs:write", "traces:write", "alerts:write", "rules:write", "profiles:write"]
  realm {
    type       = "stack"
    identifier = grafana_cloud_stack.this.id
  }
}

resource "grafana_cloud_access_policy_token" "write_only" {
  count    = var.create_write_only_token ? 1 : 0
  provider = grafana.cloud

  region           = grafana_cloud_stack.this.region_slug
  access_policy_id = grafana_cloud_access_policy.write_only[0].policy_id
  name             = local.write_only_name
}

resource "aws_ssm_parameter" "write_only" {
  count    = var.create_write_only_token ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/write-only-access-token"
  type  = "SecureString"
  value = grafana_cloud_access_policy_token.write_only[0].token

  tags = var.tags
}

resource "grafana_cloud_access_policy" "rules_management" {
  count    = var.create_rules_management_token ? 1 : 0
  provider = grafana.cloud

  region = grafana_cloud_stack.this.region_slug
  name   = local.rules_management_name
  scopes = ["rules:read", "rules:write", "adaptive-metrics-rules:read", "adaptive-metrics-rules:write", "adaptive-metrics-rules:delete"]
  realm {
    type       = "stack"
    identifier = grafana_cloud_stack.this.id
  }
}

resource "grafana_cloud_access_policy_token" "rules_management" {
  count    = var.create_rules_management_token ? 1 : 0
  provider = grafana.cloud

  region           = grafana_cloud_stack.this.region_slug
  access_policy_id = grafana_cloud_access_policy.rules_management[0].policy_id
  name             = local.rules_management_name
}

# trunk-ignore(checkov/CKV_AWS_337)
resource "aws_ssm_parameter" "rules_management" {
  count    = var.create_rules_management_token ? 1 : 0
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/rules-management-access-token"
  type  = "SecureString"
  value = grafana_cloud_access_policy_token.rules_management[0].token

  tags = var.tags
}

# trunk-ignore(checkov/CKV2_AWS_34)
resource "aws_ssm_parameter" "prometheus_url" {
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/prometheus-url"
  type  = "String"
  value = grafana_cloud_stack.this.prometheus_url

  tags = var.tags
}

# trunk-ignore(checkov/CKV_AWS_337)
resource "aws_ssm_parameter" "prometheus_user_id" {
  provider = aws.route53

  name  = "/grafana-cloud/${var.slug}/prometheus-user-id"
  type  = "SecureString"
  value = grafana_cloud_stack.this.prometheus_user_id

  tags = var.tags
}

resource "aws_ssm_parameter" "otlp_endpoint" {
  count    = var.create_write_only_token ? 1 : 0
  provider = aws.route53
  name     = "/grafana-cloud/${var.slug}/otlp-endpoint"
  type     = "String"
  value    = "${grafana_cloud_stack.this.otlp_url}/otlp"

  tags = var.tags
}

resource "aws_ssm_parameter" "otlp_user_name" {
  count    = var.create_write_only_token ? 1 : 0
  provider = aws.route53
  name     = "/grafana-cloud/${var.slug}/otlp-user-name"
  type     = "String"
  value    = grafana_cloud_stack.this.id

  tags = var.tags
}

resource "grafana_sso_settings" "this" {
  count         = var.enable_sso_saml ? 1 : 0
  provider      = grafana.stack
  provider_name = "saml"

  saml_settings {
    name                       = "SAML"
    allow_sign_up              = true
    single_logout              = true
    certificate                = var.sso_saml_certificate
    private_key                = var.sso_saml_private_key
    signature_algorithm        = "rsa-sha256"
    idp_metadata_url           = var.sso_saml_idp_metadata_url
    assertion_attribute_name   = "displayname"
    assertion_attribute_login  = "email"
    assertion_attribute_email  = "email"
    assertion_attribute_groups = "groups"
    assertion_attribute_role   = var.sso_saml_assertion_attribute_role
    role_values_admin          = var.sso_saml_role_values_admin  # "Admin"
    role_values_editor         = var.sso_saml_role_values_editor # "Editor"
    role_values_viewer         = var.sso_saml_role_values_viewer # "Viewer"
    name_id_format             = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
    enabled                    = true
    max_issue_delay            = "90s"
    metadata_valid_duration    = "48h"
  }
}

# Configure SSO using generic OAuth2
resource "grafana_sso_settings" "azuread" {
  provider      = grafana.stack
  count         = var.enable_sso_azuread ? 1 : 0
  provider_name = "azuread"
  oauth2_settings {
    name                       = "Microsoft"
    auth_url                   = var.sso_azuread_auth_url
    token_url                  = var.sso_azuread_token_url
    client_id                  = var.sso_azuread_client_id
    client_secret              = var.sso_azuread_client_secret
    allow_sign_up              = true
    auto_login                 = false
    scopes                     = "openid email profile"
    role_attribute_strict      = true
    allow_assign_grafana_admin = false
    skip_org_role_sync         = false
    use_pkce                   = true
    use_refresh_token          = true
  }
}
