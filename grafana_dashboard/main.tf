locals {
  # This crazy piece of code converts the incoming list to a map, so that we can create state objects by name instead of by index.
  json_data_map = zipmap([for item in var.config_json : item.filename], [for item in var.config_json : item.content])

  # Dashboards exported from the Grafana UI with Dynamic Dashboards enabled use the v2 schema (a Kubernetes-style envelope).
  v2_data_map = { for k, v in local.json_data_map : k => jsondecode(v) if startswith(try(jsondecode(v).apiVersion, ""), "dashboard.grafana.app/v2") }
  v1_data_map = { for k, v in local.json_data_map : k => v if !contains(keys(local.v2_data_map), k) }

  # The v2 resource requires a folder UID, whereas the v1 resource accepts an id or UID.
  folder_uid = var.folder_uid != null ? var.folder_uid : var.folder
}

resource "grafana_dashboard" "this" {
  for_each    = local.v1_data_map
  folder      = var.folder
  config_json = each.value
  overwrite   = var.overwrite
}

resource "grafana_apps_dashboard_dashboard_v2" "this" {
  for_each = local.v2_data_map

  metadata {
    uid        = each.value.metadata.name
    folder_uid = local.folder_uid
  }

  spec {
    json  = jsonencode(each.value.spec)
    title = each.value.spec.title
  }

  options {
    overwrite = var.overwrite
  }
}

resource "grafana_dashboard_permission" "this" {
  for_each      = merge(grafana_dashboard.this, grafana_apps_dashboard_dashboard_v2.this)
  dashboard_uid = try(each.value["uid"], each.value.metadata.uid)

  dynamic "permissions" {
    for_each = var.permissions
    content {
      permission = permissions.value["permission"]
      role       = permissions.value["role"]
      team_id    = permissions.value["team_id"]
      user_id    = permissions.value["user_id"]
    }
  }

  depends_on = [grafana_dashboard.this, grafana_apps_dashboard_dashboard_v2.this]
}
