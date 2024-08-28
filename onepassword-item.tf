resource "onepassword_item" "stack_vault_item" {
  count = var.create_write_only_token ? 1 : 0
  vault = var.onepassword_vault_id

  title    = "Grafana ${grafana_cloud_stack.this.slug} stack"
  category = "login"
  url      = grafana_cloud_stack.this.url


  dynamic "section" {
    for_each = var.deploy_otel_agent_k8s ? [1] : []
    content {
      label = "OpenTelemetry Collector connection details (Kubernetes):"
      field {
        label = "endpoint"
        type  = "STRING"
        value = "otel-${var.route53_record_name}.${var.otel_collector_namespace}.svc.cluster.local:4317"
      }
      field {
        label = var.enable_collector_for_external_access ? "Collector ingress URL" : "Collector ingress URL (disabled)"
        type  = "STRING"
        value = var.enable_collector_for_external_access ? "otel.dfds.cloud/${var.route53_record_name}" : "PLACEHOLDER"
      }
      field {
        label = var.enable_collector_for_external_access ? "Collector token": "Collector token (disabled)"
        type  = "CONCEALED"
        value = random_password.collector_token[0].result
      }
    }
  }

  section {
    label = "OpenTelemetry connection details (Remote):"
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
    field {
      label = "otlp-password"
      type  = "CONCEALED"
      value = grafana_cloud_access_policy_token.write_only[0].token
    }
  }

  section {
    label = "Grafana Dashboard API details:"
    field {
      label = "grafana-url"
      type  = "STRING"
      value = grafana_cloud_stack.this.url
    }
    dynamic "field" {
      for_each = length(var.service_account_editor_permissions) > 0 ? [1] : []
      content {
        label = "grafana-api-token (sa-editor)"
        type  = "CONCEALED"
        value = try(grafana_cloud_stack_service_account_token.editor[0].key, "Not created for this entry!")
      }
    }
  }
  section {
    label = "Prometheus (metrics) connection details:"
    field {
      label = "endpoint"
      type  = "STRING"
      value = grafana_cloud_stack.this.prometheus_url
    }
    field {
      label = "username"
      type  = "STRING"
      value = grafana_cloud_stack.this.prometheus_user_id
    }
    field {
      label = "password"
      type  = "CONCEALED"
      value = grafana_cloud_access_policy_token.write_only[0].token
    }
  }
  section {
    label = "Loki (logs) connection details:"
    field {
      label = "endpoint"
      type  = "STRING"
      value = grafana_cloud_stack.this.logs_url
    }
    field {
      label = "username"
      type  = "STRING"
      value = grafana_cloud_stack.this.logs_user_id
    }
    field {
      label = "password"
      type  = "CONCEALED"
      value = grafana_cloud_access_policy_token.write_only[0].token
    }
  }
  section {
    label = "Tempo (Traces) connection details:"
    field {
      label = "endpoint"
      type  = "STRING"
      value = grafana_cloud_stack.this.traces_url
    }
    field {
      label = "username"
      type  = "STRING"
      value = grafana_cloud_stack.this.traces_user_id
    }
    field {
      label = "password"
      type  = "CONCEALED"
      value = grafana_cloud_access_policy_token.write_only[0].token
    }
  }
}