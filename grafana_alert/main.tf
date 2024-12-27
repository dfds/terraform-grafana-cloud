
resource "grafana_rule_group" "alertrule" {
  for_each = { for file in var.alertrule_files : file => jsondecode(file("${file}"))
  }
  name       = each.value.groups[0].name
  folder_uid = var.folder # Folder specified in the json will be skipped since it does not contain UID.
  # This solve the example for having to convert "1m" to integer seconds
  interval_seconds = regex("^[0-9]*", each.value.groups[0].interval) * (regex("[m|h|s|d]$", each.value.groups[0].interval) == "m" ? 60 : (regex("[m|h|s|d]$", each.value.groups[0].interval) == "h" ? 3600 : (regex("[m|h|s|d]$", each.value.groups[0].interval) == "d" ? 86400: 1)))
  dynamic "rule" {
    for_each = each.value.groups[0].rules
    content {
      name           = rule.value.title
      for            = rule.value.for
      condition      = rule.value.condition
      no_data_state  = rule.value.noDataState
      annotations    = try(rule.value.annotations, null)
      exec_err_state = rule.value.execErrState
      is_paused      = rule.value.isPaused
      labels         = rule.value.labels
      dynamic "data" {
        for_each = rule.value.data
        content {
          datasource_uid = data.value.datasourceUid
          ref_id         = data.value.refId
          relative_time_range {
            from = data.value.relativeTimeRange.from
            to   = data.value.relativeTimeRange.to
          }
          model = jsonencode(data.value.model)
        }
      }
    }
  }
}
