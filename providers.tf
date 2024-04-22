provider "grafana" {
  alias = "stack"

  url   = grafana_cloud_stack.this.url
  auth  = grafana_cloud_stack_service_account_token.this.key
}
