resource "grafana_data_source" "prometheus" {
  for_each = { for file in var.data_sources : file => jsondecode(file("${file}"))
  }
  type                = "prometheus"
  name                = each.value.name
  url                 = each.value.url
  basic_auth_enabled  = true
  basic_auth_username = each.value.username

  json_data_encoded = jsonencode({
    httpMethod        = each.value.httpMethod
 })

  secure_json_data_encoded = jsonencode({
    AuthPassword = each.value.AuthPassword
  })
}