variable "title" {
  type        = string
  description = "The folder title. (Mandatory)."
}

variable "uid" {
  type        = string
  default     = null
  description = "The uid for the folder. If omitted. We will generate a random value. (Optional)."
}
