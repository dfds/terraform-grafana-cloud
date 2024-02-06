resource "grafana_dashboard" "this" {
  folder      = var.folder
  config_json = jsonencode(var.config_json)
  overwrite   = var.overwrite
}
