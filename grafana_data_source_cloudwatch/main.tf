resource "grafana_data_source" "cloudwatch" {
  for_each = { for file in var.data_sources : file => jsondecode(file("${file}"))
  }
  type = "cloudwatch"
  name = each.value.name

  json_data_encoded = jsonencode({
    defaultRegion = each.value.defaultRegion
    authType      = each.value.authType
    assumeRoleArn = each.value.assumeRoleArn
  })
}
