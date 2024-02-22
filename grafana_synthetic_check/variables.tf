variable "synthetic_files" {
  description = <<EOF
    Path to the json files with synthetic monitoring targets.
    The files must be compliant with the /api/v1/check/add method in
    https://github.com/grafana/synthetic-monitoring-api-go-client/blob/main/docs/API.md
  EOF
  type        = list(string)
  default     = []
}

variable "bearer_token" {
  description = <<EOF
    Map of bearer tokens for the synthetic monitoring targets.
    The keys are the synthetic target names and the values are the bearer tokens.
    Should never be stored in plain text, but should come from a secret manager.
  EOF
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "basic_auth" {
  description = <<EOF
    List of username and password combinations for any basic authentication required for the synthetic monitoring targets.
    The keys are the synthetic target names and the values are new maps of username and password combinations.
    Should never be stored in plain text, but should come from a secret manager.
  EOF
  type        = map(map(string))
  sensitive   = true
  default     = {}
}

variable "synthetic_probes" {
  description = <<EOF
    List of synthetic monitoring probes to use for the synthetic monitoring targets.
  EOF
  type        = list(string)
  validation {
    condition     = can(regexall("Amsterdam|Atlanta|Bangalore|CapeTown|Dallas|Frankfurt|London|Mumbai|NewYork|Newark|NorthCalifornia|NorthVirginia|Ohio|Oregon|Paris|SanFrancisco|SaoPaulo|Seoul|Singapore|Sydney|Tokyo|Toronto", join(",", var.synthetic_probes)))
    error_message = <<EOF
      Invalid value for log_level. Valid values:
      Amsterdam, Atlanta, Bangalore, CapeTown, Dallas, Frankfurt, London, Mumbai,
      NewYork, Newark, NorthCalifornia, NorthVirginia, Ohio, Oregon, Paris,
      SanFrancisco, SaoPaulo, Seoul, Singapore, Sydney, Tokyo, Toronto
    EOF
  }
  default = ["Frankfurt", "London"]
}
