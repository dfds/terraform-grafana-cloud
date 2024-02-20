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

variable "http_check_settings" {
  type = object({
    method = string                  // GET, POST, PUT, DELETE, HEAD, OPTIONS, PATCH
    bearer_token = optional(object({ # Optional
      token = string
    }), null)
    basic_auth = optional(object({ # Optional
      username = string
      password = string
    }), null)
    valid_status_codes  = list(number)
    no_follow_redirects = optional(bool, false)
  })
}
