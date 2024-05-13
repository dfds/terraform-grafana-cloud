output "read_only_multi_stack_token" {
  value     = grafana_cloud_access_policy_token.read_only_multi_stack[*].token
  sensitive = true
}

output "grafana_url" {
  value = grafana_cloud_stack.this.url
}

output "terraform_sa_token" {
  value     = grafana_cloud_stack_service_account_token.this.key
  sensitive = true
}
