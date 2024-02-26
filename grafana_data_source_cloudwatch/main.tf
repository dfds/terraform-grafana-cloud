


resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = var.cloudwatch_connection.name

  json_data_encoded = jsonencode({
    defaultRegion = var.cloudwatch_connection.defaultRegion
    authType      = "grafana_assume_role"
    assumeRoleArn = var.cloudwatch_connection.assumeRoleArn
  })
}

variable "cloudwatch_connection" {
  type = object({
    name          = string
    defaultRegion = string
    assumeRoleArn = string
  })
}
