
data "grafana_synthetic_monitoring_probes" "this" {}

resource "grafana_synthetic_monitoring_check" "http" {
  for_each = { for file in var.synthetic_files : file => jsondecode(file(file))
  }
  job       = each.value.job
  target    = each.value.target
  enabled   = try(each.value.enabled, true)
  frequency = try(each.value.frequency, 60000)
  timeout   = try(each.value.timeout, 3000)
  probes = [
    data.grafana_synthetic_monitoring_probes.this.probes.Frankfurt,
    data.grafana_synthetic_monitoring_probes.this.probes.London,
  ]
  labels = try(each.value.labels, {})

  settings {
    http {
      method       = upper(try(each.value.settings.method, "GET"))
      bearer_token = try(each.value.settings.bearer_token, null)
      dynamic "basic_auth" {
        for_each = try([each.value.settings.basic_auth], [])
        content {
          username = try(each.value.settings.basic_auth.username, null)
          password = try(each.value.settings.basic_auth.password, null)
        }
      }
      valid_status_codes  = try(each.value.settings.valid_status_codes, [200])
      no_follow_redirects = try(each.value.settings.no_follow_redirects, false)
    }
  }
}
