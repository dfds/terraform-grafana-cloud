locals {
  otlp_auth_header = var.create_write_only_token ? base64encode("${grafana_cloud_stack.this.id}:${grafana_cloud_access_policy_token.write_only[0].token}") : ""
  collector_token_base64 = base64encode(random_password.collector_token.result)
}

resource "random_password" "collector_token" {
  length           = 40
  special          = true
  override_special = "!#$%&*()-_=+?"
}