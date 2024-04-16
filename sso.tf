resource "grafana_sso_settings" "this" {
  provider = grafana.stack
  count = var.saml_enabled ? 1 : 0

  provider_name = var.sso_provider

  saml_settings {
    name = var.saml_name
    allow_sign_up = var.allow_sign_up
    single_logout = var.single_logout
    certificate = var.certificate
    private_key = var.private_key
    signature_algorithm = var.signature_algorithm
    idp_metadata_url = var.idp_metadata_url
    assertion_attribute_name = var.assertion_attribute_name
    assertion_attribute_login = var.assertion_attribute_login
    assertion_attribute_email = var.assertion_attribute_email
    assertion_attribute_groups = var.assertion_attribute_groups
    assertion_attribute_role = var.assertion_attribute_role
    role_values_admin = var.role_values_admin
    role_values_editor = var.role_values_editor
    name_id_format = var.name_id_format
    enabled = var.saml_enabled
  }
}
