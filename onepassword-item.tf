resource "onepassword_item" "stack_vault_item" {
  count = var.create_write_only_token ? 1 : 0
  vault = var.onepassword_vault_id

  title    = "Grafana ${grafana_cloud_stack.this.slug} stack"
  category = "login"
  url      = grafana_cloud_stack.this.url
  section {
    label = "Stack details:"

    field {
      label = "terraform-sa-editor-access-token"
      type  = "CONCEALED"
      value = try(grafana_cloud_stack_service_account_token.editor[0].key, "Not created for this entry!")
    }
    field {
      label = "write-only-access-token"
      type  = "CONCEALED"
      value = grafana_cloud_access_policy_token.write_only[0].token
    }
    field {
      label = "otlp-endpoint"
      type  = "STRING"
      value = "${grafana_cloud_stack.this.otlp_url}/otlp"
    }
    field {
      label = "otlp-user-name"
      type  = "STRING"
      value = grafana_cloud_stack.this.id
    }
  }
}
