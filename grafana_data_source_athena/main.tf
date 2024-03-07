resource "grafana_data_source" "athena" {
  for_each = { for file in var.data_sources : file => jsondecode(file("${file}"))
  }
  type = "grafana-athena-datasource"
  name = each.value.name

  json_data_encoded = jsonencode({
    defaultRegion  = each.value.defaultRegion
    authType       = each.value.authType
    assumeRoleArn  = each.value.assumeRoleArn
    catalog        = each.value.catalog,
    database       = each.value.database,
    defaultRegion  = each.value.defaultRegion,
    outputLocation = each.value.outputLocation,
    workgroup      = each.value.workgroup
  })
}
