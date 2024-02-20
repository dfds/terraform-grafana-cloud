
data "grafana_synthetic_monitoring_probes" "this" {}


resource "grafana_synthetic_monitoring_check" "http" {

  job     = var.job
  target  = var.target
  enabled = var.is_enabled
  probes = [
    data.grafana_synthetic_monitoring_probes.this.probes.Frankfurt,
    data.grafana_synthetic_monitoring_probes.this.probes.London,
  ]
  labels = var.labels

  settings {
    http {
      method = upper(var.http_check_settings.method)
      dynamic "bearer_token" {
        for_each = var.http_check_settings.bearer_token != null ? [var.http_check_settings.bearer_token] : []
        content {
          token = var.http_check_settings.bearer_token.token
        }
      }
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
