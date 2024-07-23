variable "data_sources" {
  type = list(object({
    name                     = string
    type                     = string
    url                      = optional(string)
    basic_auth_enabled       = optional(bool)
    basic_auth_username      = optional(string)
    is_default               = optional(bool)
    json_data_encoded        = optional(string)
    secure_json_data_encoded = optional(string)
  }))
  description = "List of data sources"
}
