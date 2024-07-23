resource "grafana_data_source" "this" {
  for_each = { for data_source in var.data_sources : format("%s-%s", data_source.type, data_source.name) => data_source }

  name                     = each.value.name
  type                     = each.value.type
  url                      = lookup(each.value, "url", "")
  basic_auth_enabled       = lookup(each.value, "basic_auth_enabled", false)
  basic_auth_username      = lookup(each.value, "basic_auth_username", "")
  json_data_encoded        = lookup(each.value, "json_data_encoded", "")
  is_default               = lookup(each.value, "is_default", false)
  secure_json_data_encoded = lookup(each.value, "secure_json_data_encoded", "")
}
