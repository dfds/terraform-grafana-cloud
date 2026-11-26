output "meta" {
  value = concat(
    [for d in grafana_dashboard.this : {
      title   = jsondecode(d.config_json).title
      url     = d.url
      uid     = d.uid
      version = d.version
    }],
    [for d in grafana_apps_dashboard_dashboard_v2.this : {
      title   = d.spec.title
      url     = d.metadata.url
      uid     = d.metadata.uid
      version = d.metadata.version
    }]
  )
}
