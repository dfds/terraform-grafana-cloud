locals {
    otlp_auth_header = base64encode("${grafana_cloud_stack.this.id}:${grafana_cloud_access_policy_token.write_only[0].token}")
}

resource "helm_release" "otel_collector" {
    count = var.deploy_otel_agent_k8s ? 1 : 0
    name = var.slug
    namespace = var.otel_collector_namespace
    repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
    chart = "opentelemetry-collector"
    version = var.otel_collector_chart_version

    values = [
        templatefile("${path.module}/otel-collector/values.yaml", {
            otlphttp_endpoint = "${grafana_cloud_stack.this.otlp_url}/otlp"
            stack_token = local.otlp_auth_header
            name = var.slug
            owner = "CloudEngineering"
        })
    ]
}