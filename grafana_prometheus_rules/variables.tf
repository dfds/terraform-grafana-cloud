variable "prometheus_rule_files" {
  description = "Path to the yaml files with Prometheus rules"
  type        = list(string)
}

variable "prometheus_url" {
  description = "Prometheus URL"
  type        = string
}

variable "prometheus_user_id" {
  description = "Prometheus User ID"
  type        = string
}

variable "rules_management_access_token" {
  description = "Token"
  type        = string
  sensitive   = true
}
