output "meta" {
  value = [for d in grafana_dashboard.this : {
    title   = jsondecode(d.config_json).title
    url     = d.url
    uid     = d.uid
    version = d.version
  }]
}
