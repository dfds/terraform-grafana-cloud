output "uid" {
  value = [for d in grafana_dashboard.this : d.uid]
}
