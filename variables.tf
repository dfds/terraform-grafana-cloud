variable "stack_name" {
  type        = string
  description = "Name of stack"
  default     = null
}

variable "slug" {
  type        = string
  description = "Subdomain that the Grafana instance will be available at (i.e. setting slug to empty string will make the instance available at `https://.grafana.net`"
  default     = null
}

variable "region_slug" {
  type        = string
  description = "Region slug to assign to this stack. Changing region will destroy the existing stack and create a new one in the desired region"
  default     = null
}

variable "stack_description" {
  type        = string
  description = "Description of stack"
  default     = null
}

variable "hosted_zone_name" {
  type        = string
  description = "Name of the hosted zone to contain the route53 record. If unspecified no route53 record is created."
  default     = null
}

variable "url" {
  type        = string
  description = "Custom URL for the Grafana instance. Should not be specified when passing `hosted_zone_name`"
  default     = null
}

variable "grafana_folders" {
  type        = list(string)
  description = "List of grafana folders to be created"
  default     = []
}

variable "route53_record_name" {
  type        = string
  description = "Name of the route53 record"
  default     = null
}

variable "plugins" {
  type = list(object({
    plugin  = string
    version = string
  }))
  description = "List of plugins"
  default     = []
}

variable "install_synthetic_monitoring" {
  type        = bool
  description = "Whether to install synthetic monitoring"
}

variable "create_read_only_token" {
  type        = bool
  description = "Whether to create a read-only token"
  default     = false
}

variable "teams" {
  type = list(object({
    name        = string
    groups      = list(string)
    permissions = list(string)
  }))
  description = "List of teams to create with the groups and permissions"
  default     = []
}

variable "stacks_for_multi_stack_querying" {
  type        = list(string)
  description = "List of stacks to create access token for multiple stacks"
  default     = []
}

variable "create_write_only_token" {
  type        = bool
  description = "Whether to create a write-only token"
  default     = false
}

variable "create_rules_management_token" {
  type        = bool
  description = "Whether to create a rules management token"
  default     = false
}

variable "stack_labels" {
  type        = map(string)
  description = "Map of labels to apply to the stack"
  default     = {}
}

## SSO SAML Configurations
variable "enable_sso_saml" {
  type        = bool
  default     = false
  description = "Enable SSO SAML"
}

variable "sso_saml_certificate" {
  type        = string
  description = "Base64-encoded certificate"
  default     = ""
}
variable "sso_saml_private_key" {
  type        = string
  description = "Base64-encoded private key"
  default     = ""
}

variable "sso_saml_idp_metadata_url" {
  type        = string
  description = "The URL to the IDP metadata"
  default     = ""
}

variable "sso_saml_assertion_attribute_role" {
  type        = string
  default     = ""
  description = "The attribute to use for role mapping"
}

variable "sso_saml_role_values_admin" {
  type        = string
  default     = ""
  description = "List of comma- or space-separated roles which will be mapped into the Admin role used in the saml response"
}
variable "sso_saml_role_values_viewer" {
  type        = string
  default     = ""
  description = "List of comma- or space-separated roles which will be mapped into the Viewer role used in the saml response"
}
variable "sso_saml_role_values_editor" {
  type        = string
  default     = ""
  description = "List of comma- or space-separated roles which will be mapped into the Viewer role used in the saml response"
}

variable "deploy_otel_agent_k8s" {
  type        = bool
  description = "Whether to deploy the OpenTelemetry agent into a Kubernetes cluster"
  default     = false
}

variable "enable_collector_for_external_access" {
  type        = bool
  description = "Whether to enable external access to the OpenTelemetry agent from outside the Kubernetes cluster"
  default     = false
}

variable "otel_collector_namespace" {
  type        = string
  description = "Namespace to deploy the OpenTelemetry agent into"
  default     = "grafana"
}

variable "otel_collector_chart_version" {
  type        = string
  description = "Version of the Open Telemetry collector helm chart to deploy"
  default     = null
}

variable "onepassword_vault_id" {
  type        = string
  description = "The ID of the vault to store the stack information in"
}

variable "service_account_editor_permissions" {
  type        = list(string)
  description = "List of permissions for the service account for stack editors"
}

variable "enable_sso_azuread" {
  type        = bool
  default     = false
  description = "Enable SSO Azure AD"
}

variable "sso_azuread_client_id" {
  type        = string
  description = "Application ID of the Azure AD application"
  default = ""
}
variable "sso_azuread_client_secret" {
  type        = string
  description = "Client secret of the Azure AD application"
  default = ""
}
variable "sso_azuread_auth_url" {
  type        = string
  description = "OAuth2 authorization URL for SSO Azure AD"
  default = ""
}
variable "sso_azuread_token_url" {
  type        = string
  description = "OAuth2 token URL for SSO Azure AD"
  default = ""
}
