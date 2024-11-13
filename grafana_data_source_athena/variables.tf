variable "data_sources" {
  description = "Path to the json files with data sources"
  type        = list(string)
}

variable "enable_caching" {
  description = "Enable caching for the data source"
  type        = bool
  default     = true
}

variable "grafana_url" {
  description = "URL of the Grafana instance"
  type        = string
  default     = ""
}

variable "bearer_token" {
  description = "Bearer token for the Grafana API"
  sensitive   = true
  type        = string
  default     = ""
}
