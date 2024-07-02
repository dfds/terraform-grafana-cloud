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

output "stack_traces_url" {
  value = grafana_cloud_stack.this.traces_url
}

output "stack_logs_url" {
  value = grafana_cloud_stack.this.logs_url
}

output "stack_prometheus_url" {
  value = grafana_cloud_stack.this.prometheus_url
}

output "stack_otlp_url" {
  value = grafana_cloud_stack.this.otlp_url
}

output "stack_otlp_id" {
  value = grafana_cloud_stack.this.id
}

output "write_only_token" {
  value     = try(grafana_cloud_access_policy_token.write_only[0].token, null)
  sensitive = true
}
