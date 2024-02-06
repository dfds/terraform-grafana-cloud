output "uid" {
  value = [for dashboard in grafana_dashboard.this : dashboard.uid]
}

output "url" {
  value = [for dashboard in grafana_dashboard.this : dashboard.url]
}
