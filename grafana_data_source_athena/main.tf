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

# trunk-ignore(tflint/terraform_unused_declarations)
data "http" "enable_caching" {
  for_each = var.enable_caching && var.grafana_url != "" && nonsensitive(var.bearer_token) != "" ? grafana_data_source.athena : {}
  url      = "${var.grafana_url}/api/datasources/${grafana_data_source.athena[each.key].uid}/cache/enable"
  method   = "POST"

  request_headers = {
    Accept        = "application/json"
    Authorization = "Bearer ${var.bearer_token}"
  }

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Status code invalid for enabling caching for Athena data source"
    }
  }
}
