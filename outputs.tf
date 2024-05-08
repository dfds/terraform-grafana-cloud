output "read_only_multi_stack_token" {
  value = grafana_cloud_access_policy_token.read_only_multi_stack[*].token
  sensitive = true
}
