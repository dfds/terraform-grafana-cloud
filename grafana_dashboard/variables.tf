variable "config_json" {
  type        = list(map(string))
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

variable "permissions" {
  type = list(object({
    permission = string
    role       = optional(string)
    team_id    = optional(string)
    user_id    = optional(string)
  }))
  description = "The permission items to add/update. Items that are omitted from the list will be removed."
  default = [{
    permission = "Edit"
    role       = "Editor"
    team_id    = 0
    user_id    = 0
  }]
  validation {
    condition = alltrue([
      for record in var.permissions : contains(["View", "Edit", "Admin"], record["permission"])
    ])
    error_message = "The permission must be either View, Edit or Admin"
  }
}
