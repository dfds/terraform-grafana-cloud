variable "stack_name" {
  type = string
  description = "Name of stack"
  default = null
}

variable "slug" {
  type = string
  description = "Subdomain that the Grafana instance will be available at (i.e. setting slug to empty string will make the instance available at `https://.grafana.net`"
  default = null
}

variable "region_slug" {
  type = string
  description = "Region slug to assign to this stack. Changing region will destroy the existing stack and create a new one in the desired region"
  default = null
}

variable "stack_description" {
  type = string
  description = "Description of stack"
  default = null
}

variable "hosted_zone_name" {
  type = string
  description = "Name of the hosted zone to contain the route53 record. If unspecified no route53 record is created."
  default = null
}

variable "url" {
  type = string
  description = "Custom URL for the Grafana instance. Should not be specified when passing `hosted_zone_name`"
  default = null
}

variable "grafana_folders" {
  type = list(string)
  description = "List of grafana folders to be created"
  default = []
}

variable "route53_record_name" {
  type = string
  description = "Name of the route53 record"
  default = null
}
