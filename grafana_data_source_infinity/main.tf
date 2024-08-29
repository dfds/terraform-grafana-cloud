resource "grafana_data_source" "this" {
  for_each = { for file in var.data_sources : file => jsondecode(file("${file}"))
  }
  type = "yesoreyeram-infinity-datasource"
  name = each.value.name

  json_data_encoded = jsonencode({
    allowedHosts             = each.value.allowedHosts
    auth_method              = each.value.auth_method
    customHealthCheckEnabled = each.value.customHealthCheckEnabled
    customHealthCheckUrl     = each.value.customHealthCheckUrl
  })

  secure_json_data_encoded = jsonencode({
    bearerToken = var.bearer_token
  })
}
