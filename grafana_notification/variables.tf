
variable "notification_enabled" {
  type        = bool
  default     = false
  description = "Enable notifications."
}

variable "name" {
  type        = string
  default     = "Slack"
  description = "Name of the contact point."
}

variable "slack_webhook_url" {
  type        = string
  default     = ""
  description = "Slack webhook URL."
  sensitive   = true
}

variable "slack_username" {
  type        = string
  default     = "The All-Seeing Eye"
  description = "Slack username."
}

variable "slack_icon_emoji" {
  type        = string
  default     = ":sauron:"
  description = "Slack emoji."
}

variable "group_interval" {
  type        = string
  default     = "5m"
  description = "Minimum time interval between two notifications for the same group. Default is 5 minutes."
}

variable "repeat_interval" {
  type        = string
  default     = "4h"
  description = "Minimum time interval for re-sending a notification if an alert is still firing. Default is 4 hours."
}

variable "group_wait" {
  type        = string
  default     = "30s"
  description = "Time to wait to buffer alerts of the same group before sending a notification. Default is 30 seconds"
}

variable "policy_enabled" {
  type        = bool
  default     = false
  description = "Enable alert policies."
}

variable "policy_matcher" {
  type = list(map(string))
  default = [{
    label = "mylabel"
    match = "="
    value = "myvalue"
  }]
  description = "Matcher for the notification policy."
}

/* Example syntax
additional_policies = [
  {
    contact_point = "Cloud Engineering - SSU Slack"
    group_by = ["grafana_folder"]
    repeat_interval = "24h"
    matcher = [
      {
        label = "grafana_folder"
        match = "="
        value = "Cloud Engineering - SSU"
      }]
  }
]
*/
variable "additional_policies" {
  type = list(object({
    contact_point   = string
    group_by        = list(string)
    matcher         = list(map(string))
    repeat_interval = string
  }))
  default     = []
  description = "Pass extra policies as is"
}
