variable "folder" {
  description = "UID of the folder to create the alert rules in"
  type        = string
}

variable "alertrule_files" {
  description = "Path to the json files with alert rules"
  type        = list(string)
}
