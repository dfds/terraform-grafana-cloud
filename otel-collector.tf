locals {
  otlp_auth_header = var.create_write_only_token ? base64encode("${grafana_cloud_stack.this.id}:${grafana_cloud_access_policy_token.write_only[0].token}") : ""
  collecot_token_base64 = var.deploy_otel_agent_k8s && var.enable_collector_for_external_access ? base64encode(random_password.collector_token[0].result) : "PLACEHOLDER"
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
      collector_token = local.collecot_token_base64
      enable_collector_for_external_access = var.enable_collector_for_external_access
      diagram_otel_receiver_endpoint = var.diagram_otel_receiver_endpoint
      enable_collector_tailsampling = var.enable_collector_tailsampling
      collector_tailsampling_probablistic_percentage = var.collector_tailsampling_probablistic_percentage
    })
  ]
}


resource "random_password" "collector_token" {
  count            = var.deploy_otel_agent_k8s && var.enable_collector_for_external_access ? 1 : 0
  length           = 40
  special          = true
  override_special = "!#$%&*()-_=+?"
}

resource "kubernetes_manifest" "ingress_route" {
  count      = var.deploy_otel_agent_k8s && var.enable_collector_for_external_access ? 1 : 0
  manifest = {
    "apiVersion" = "traefik.io/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "otel-${var.route53_record_name}"
      "namespace" = var.otel_collector_namespace
    }
    "spec" = {
       "entryPoints" = []
        "routes" = [
          {
            "kind" = "Rule"
            "match" = "Host(`otel.dfds.cloud`) && PathPrefix(`/${var.route53_record_name}`)"
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
  count      = var.deploy_otel_agent_k8s && var.enable_collector_for_external_access ? 1 : 0
  manifest = {
    "apiVersion" = "traefik.io/v1alpha1"
    "kind"       = "Middleware"
    "metadata" = {
      "name"      = "otel-${var.route53_record_name}"
      "namespace" = var.otel_collector_namespace
    }
    "spec" = {
      "stripPrefix" = {
        "prefixes" = [
          "/${var.route53_record_name}"
        ]
      }
    }
  }
}
