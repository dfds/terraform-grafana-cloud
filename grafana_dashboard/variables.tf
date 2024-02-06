variable "config_json" {
  type        = list(string)
  description = "A list of files of with JSON content."
}

variable "folder" {
  type        = string
  default     = null
  description = "The id or UID of the folder to optionally save the dashboard in."
}

variable "overwrite" {
  type        = bool
  default     = true
  description = "Set to true if you want to overwrite existing dashboard with newer version, same dashboard title in folder or same dashboard uid."
}
