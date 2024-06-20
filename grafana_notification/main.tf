resource "grafana_contact_point" "this" {
  count = var.notification_enabled ? 1 : 0
  name  = var.name

  slack {
    username   = var.slack_username
    url        = var.slack_webhook_url
    icon_emoji = var.slack_icon_emoji
  }
}


resource "grafana_notification_policy" "this" {
  count              = var.notification_enabled && var.policy_enabled ? 1 : 0
  group_by           = ["..."]
  disable_provenance = true
  contact_point      = "grafana-default-email"

  group_wait      = var.group_wait
  group_interval  = var.group_interval
  repeat_interval = var.repeat_interval

  policy {
    contact_point = grafana_contact_point.this[count.index].name
    group_by      = ["grafana_folder"]
    dynamic "matcher" {
      for_each = var.policy_matcher
      content {
        label = matcher.value.label
        match = matcher.value.match
        value = matcher.value.value
      }
    }
    policy {
      repeat_interval = "24h"
      matcher {
        label = "repeat"
        match = "eq"
        value = "24h"
      }
    }
  }
}
