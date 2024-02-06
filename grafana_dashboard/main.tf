resource "grafana_dashboard" "this" {
  for_each    = toset(var.config_json)
  folder      = var.folder
  config_json = each.value
  overwrite   = var.overwrite
}

resource "grafana_dashboard_permission" "this" {
  count         = length(grafana_dashboard.this)
  dashboard_uid = grafana_dashboard.this[count.index].uid

  dynamic "permissions" {
    for_each = var.permissions
    content {
      role       = permissions.value["permission"]
      permission = permissions.value["role"]
      team_id    = permissions.value["team_id"]
      user_id    = permissions.value["user_id"]
    }
  }

  depends_on = [grafana_dashboard.this]
}
