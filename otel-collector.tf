locals {
  otlp_auth_header = var.create_write_only_token ? base64encode("${grafana_cloud_stack.this.id}:${grafana_cloud_access_policy_token.write_only[0].token}") : ""
}

resource "helm_release" "otel_collector" {
  count      = var.deploy_otel_agent_k8s ? 1 : 0
  name       = "otel-collector-${var.slug}"
  namespace  = var.otel_collector_namespace
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  version    = var.otel_collector_chart_version

  values = [
    templatefile("${path.module}/otel-collector/values.yaml", {
      otlphttp_endpoint = "${grafana_cloud_stack.this.otlp_url}/otlp"
      stack_token       = local.otlp_auth_header
      name              = "otel-${var.route53_record_name}"
      owner             = "CloudEngineering"
      stack             = var.slug
    })
  ]
}

resource "kubernetes_manifest" "ingress_route" {
  count      = var.deploy_otel_agent_k8s && var.enable_external_access ? 1 : 0
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "otel-${var.route53_record_name}"
      "namespace" = var.otel_collector_namespace
    }
    "spec" = {
      "foo" = "bar"
       "entryPoints" = []
        "routes" = [
          {
            "kind" = "Rule"
            "match" = "Host(`api.hellman.oxygen.dfds.cloud`) && PathPrefix(`/otel-${var.route53_record_name}`)"
            "middlewares" = [
              {
                "name"     = "otel-${var.route53_record_name}"
                "priority" = 0
              }
            ]
            "services" = [
              {
                "kind" = "Service"
                "name" = "otel-${var.route53_record_name}"
                "port" = "external"
              }
            ]
          }
        ]
    }
  }
}

resource "kubernetes_manifest" "middleware" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "otel-${var.route53_record_name}"
      "namespace" = var.otel_collector_namespace
    }
    "spec" = {
      "stripPrefix" = {
        "prefixes" = [
          "/otel-${var.route53_record_name}"
        ]
      }
    }
  }
}