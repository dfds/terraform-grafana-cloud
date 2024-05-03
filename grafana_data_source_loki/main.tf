resource "grafana_data_source" "loki" {
  for_each = { for file in var.data_sources : file => jsondecode(file("${file}"))
  }
  type                = "loki"
  name                = each.value.name
  url                 = each.value.url
  basic_auth_enabled  = true
  basic_auth_username = each.value.username

  secure_json_data_encoded = jsonencode({
    AuthPassword = each.value.AuthPassword
  })
}