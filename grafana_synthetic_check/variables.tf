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
