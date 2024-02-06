resource "grafana_dashboard_permission" "this" {
  dashboard_uid = var.uid

  dynamic "permissions" {
    for_each = var.permissions
    content {
      role       = permissions.value["permission"]
      permission = permissions.value["role"]
      team_id    = permissions.value["team_id"]
      user_id    = permissions.value["user_id"]
    }
  }
}
