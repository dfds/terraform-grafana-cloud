terraform {
  required_version = ">= 1.8.0"

  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 2.9.0"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 2.9.0"
    }
  }
}
