terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.34.0"
      configuration_aliases = [aws.route53]
    }
    grafana = {
      source                = "grafana/grafana"
      version               = ">= 2.9.0"
      configuration_aliases = [grafana.cloud]
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.14.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = ">= 2.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}