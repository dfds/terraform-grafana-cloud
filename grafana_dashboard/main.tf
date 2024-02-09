locals {
  # This crazy piece of code converts the incoming list to a map, so that we can create state objects by name instead of by index.
  json_data_map = zipmap([for item in var.config_json : item.filename], [for item in var.config_json : item.content])
}

resource "grafana_dashboard" "this" {
  for_each    = local.json_data_map
  folder      = var.folder
  config_json = each.value
  overwrite   = var.overwrite
}

resource "grafana_dashboard_permission" "this" {
  for_each      = grafana_dashboard.this
  dashboard_uid = each.value["uid"]

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
