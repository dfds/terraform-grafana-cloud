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

variable "enable_otlp" {
  type        = bool
  description = "Whether to enable OpenTelemetry"
  default     = false
}

variable "create_read_only_token" {
  type        = bool
  description = "Whether to create a read-only token"
  default     = false
}

variable "sso_provider" {
  type = string
  description = "The name of the SSO provider. Supported values: github, gitlab, google, azuread, okta, generic_oauth, saml"
  default = "saml"
}

variable "saml_name" {
  type = string
  description = "Display name for the saml configuration"
  default = "SAML"
}

variable "allow_sign_up" {
  type = bool
  description = "Whether to allow new Grafana user creation through SAML login. If set to false, then only existing Grafana users can log in with SAML."
  default = null
}

variable "single_logout" {
  type = bool
  description = "Whether SAML Single Logout is enabled"
  default = null
}

variable "certificate" {
  type = string
  description = "Base64-encoded string for the SP X.509 certificate"
  sensitive = true
  default = ""
}

variable "private_key" {
  type = string
  description = "Base64-encoded string for the SP private key"
  sensitive = true
  default = ""
}

variable "signature_algorithm" {
  type = string
  description = "Signature algorithm used for signing requests to the IdP. Supported values are rsa-sha1, rsa-sha256, rsa-sha512"
  default = "rsa-sha256"
}

variable "idp_metadata_url" {
  type = string
  description = "URL for the IdP SAML metadata XML"
  default = ""
}

variable "assertion_attribute_name" {
  type = string
  description = "Friendly name or name of the attribute within the SAML assertion to use as the user name"
  default = ""
}

variable "assertion_attribute_login" {
  type = string
  description = "Friendly name or name of the attribute within the SAML assertion to use as the user login handle"
  default = ""
}

variable "assertion_attribute_email" {
  type = string
  description = "Friendly name or name of the attribute within the SAML assertion to use as the user email"
  default = ""
}

variable "assertion_attribute_groups" {
  type = string
  description = "Friendly name or name of the attribute within the SAML assertion to use as the user groups"
  default = ""
}

variable "assertion_attribute_role" {
  type = string
  description = "Friendly name or name of the attribute within the SAML assertion to use as the user roles"
  default = ""
}

variable "role_values_admin" {
  type = string
  description = "List of comma- or space-separated roles which will be mapped into the Admin role"
  default = ""
}

variable "role_values_editor" {
  type = string
  description = "List of comma- or space-separated roles which will be mapped into the Editor role"
  default = ""
}

variable "name_id_format" {
  type = string
  description = "The Name ID Format to request within the SAML assertion"
  default = ""
}

variable "saml_enabled" {
  type = bool
  description = "Define whether this configuration is enabled for the specified provider"
  default = false
}
