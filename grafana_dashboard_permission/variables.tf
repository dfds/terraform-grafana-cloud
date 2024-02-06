variable "uid" {
  type        = string
  description = "UID of the dashboard to apply permissions to."
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
