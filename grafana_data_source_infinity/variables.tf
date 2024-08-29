variable "data_sources" {
  description = "Path to the json files with data sources"
  type        = list(string)
}

variable "bearer_token" {
  description = "Should be passed in through an environment variable from a secret management system when needed."
  type        = string
  default     = ""
  sensitive   = true
}
