
data "grafana_synthetic_monitoring_probes" "main" {}


variable "job" {
  description = "The job name to associate the check with"
  type        = string
}

variable "target" {
  description = "The target to check"
  type        = string
}

variable "is_enabled" {
  description = "Whether the check is enabled"
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to associate with the check"
  type        = map(string)
  default     = {}
}

# variable "settings" {
#   description = "The settings for the check"
#   type = object({
#     http = object({
#       method = string
#     })
#   })
# }
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
      basic_auth {
        username = var.http_check_settings.basic_auth.username
        password = var.http_check_settings.basic_auth.password
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

# basic_auth (Block Set, Max: 1) Basic auth settings. (see below for nested schema)
# bearer_token (String) Token for use with bearer authorization header.
# body (String) The body of the HTTP request used in probe.
# cache_busting_query_param_name (String) The name of the query parameter used to prevent the server from using a cached response. Each probe will assign a random value to this parameter each time a request is made.
# fail_if_body_matches_regexp (Set of String) List of regexes. If any match the response body, the check will fail.
# fail_if_body_not_matches_regexp (Set of String) List of regexes. If any do not match the response body, the check will fail.
# fail_if_header_matches_regexp (Block Set) Check fails if headers match. (see below for nested schema)
# fail_if_header_not_matches_regexp (Block Set) Check fails if headers do not match. (see below for nested schema)
# fail_if_not_ssl (Boolean) Fail if SSL is not present. Defaults to false.
# fail_if_ssl (Boolean) Fail if SSL is present. Defaults to false.
# headers (Set of String) The HTTP headers set for the probe.
# ip_version (String) Options are V4, V6, Any. Specifies whether the corresponding check will be performed using IPv4 or IPv6. The Any value indicates that IPv6 should be used, falling back to IPv4 if that's not available. Defaults to V4.
# method (String) Request method. One of GET, CONNECT, DELETE, HEAD, OPTIONS, POST, PUT, TRACE Defaults to GET.
# no_follow_redirects (Boolean) Do not follow redirects. Defaults to false.
# proxy_connect_headers (Set of String) The HTTP headers sent to the proxy URL
# proxy_url (String) Proxy URL.
# tls_config (Block Set, Max: 1) TLS config. (see below for nested schema)
# valid_http_versions (Set of String) List of valid HTTP versions. Options include HTTP/1.0, HTTP/1.1, HTTP/2.0
# valid_status_codes (Set

# /api/v1/register/install



# GET http://xxxx.grafana.com/api/dashboards/db/mydash HTTP/1.1

# data "grafana_cloud_stack" "test" {
#   slug = "samdisandbox"
# }
