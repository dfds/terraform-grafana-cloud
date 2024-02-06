resource "grafana_dashboard" "this" {
  for_each    = toset(var.config_json)
  folder      = var.folder
  config_json = each.value
  overwrite   = var.overwrite
}
