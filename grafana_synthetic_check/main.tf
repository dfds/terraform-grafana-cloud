data "grafana_synthetic_monitoring_probe" "this" {
  count = length(var.synthetic_probes)
  name  = var.synthetic_probes[count.index]
}

resource "grafana_synthetic_monitoring_check" "http" {
  for_each = { for file in var.synthetic_files : file => jsondecode(file(file))
  }
  job       = each.value.job
  target    = each.value.target
  enabled   = try(each.value.enabled, true)
  frequency = try(each.value.frequency, 60000)
  timeout   = try(each.value.timeout, 3000)
  probes = [
    for probe in data.grafana_synthetic_monitoring_probe.this :
    probe.id
  ]
  labels = try(each.value.labels, {})

  settings {
    http {
      method = upper(try(each.value.settings.method, "GET"))
      # This will check if var.bearer_token map contains a name that matches the bearer_token value from the synthetic file.
      # If so it will use the token from the map.
      bearer_token = try(lookup(var.bearer_token, each.value.settings.bearer_token, null), null)
      dynamic "basic_auth" {
        # This lookup will check if var.basic_auth map contains a name that matches the basic_auth value from the synthetic file.
        # If so it will treat it as a list with one record that contains a child map with username and password.
        for_each = try(lookup(var.basic_auth, each.value.settings.basic_auth, null), null) != null ? try([each.value.settings.basic_auth], []) : []
        content {
          # It will lookup the username from the child map.
          username = lookup(lookup(var.basic_auth, each.value.settings.basic_auth, {}), "username", null)
          # It will lookup the password from the child map.
          password = lookup(lookup(var.basic_auth, each.value.settings.basic_auth, {}), "password", null)
        }
      }
      valid_status_codes  = try(each.value.settings.valid_status_codes, [200])
      no_follow_redirects = try(each.value.settings.no_follow_redirects, false)
    }
  }
}
