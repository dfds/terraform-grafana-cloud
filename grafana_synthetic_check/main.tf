
data "grafana_synthetic_monitoring_probes" "main" {}


resource "grafana_synthetic_monitoring_check" "http" {

  job     = var.job
  target  = var.target
  enabled = var.is_enabled
  probes = [
    data.grafana_synthetic_monitoring_probes.main.probes.Frankfurt,
    data.grafana_synthetic_monitoring_probes.main.probes.London,
  ]
  labels = var.labels

  settings {
    http {
      method = var.http_check_settings.method
      dynamic "basic_auth" {
        for_each = var.http_check_settings.basic_auth != null ? [var.http_check_settings.basic_auth] : []
        content {
          username = var.http_check_settings.basic_auth.username
          password = var.http_check_settings.basic_auth.password
        }
      }
      valid_status_codes  = var.http_check_settings.valid_status_codes
      no_follow_redirects = var.http_check_settings.no_follow_redirects
    }
  }
}

variable "http_check_settings" {
  type = object({
    method = string                // GET, POST, PUT, DELETE, HEAD, OPTIONS, PATCH
    basic_auth = optional(object({ # Optional
      username = string
      password = string
    }), null)
    valid_status_codes  = list(number)
    no_follow_redirects = optional(bool, false)
  })
}
