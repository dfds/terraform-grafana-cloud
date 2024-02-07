resource "grafana_dashboard" "this" {
  count       = length(var.config_json)
  folder      = var.folder
  config_json = var.config_json[count.index]["content"]
  overwrite   = var.overwrite
}

resource "grafana_dashboard_permission" "this" {
  count         = length(grafana_dashboard.this)
  dashboard_uid = grafana_dashboard.this[count.index].uid

  dynamic "permissions" {
    for_each = var.permissions
    content {
      permission = permissions.value["permission"]
      role       = permissions.value["role"]
      team_id    = permissions.value["team_id"]
      user_id    = permissions.value["user_id"]
    }
  }

  depends_on = [grafana_dashboard.this]
}
