variable "synthetic_files" {
  description = <<EOF
    Path to the json files with synthetic monitoring targets.
    The files must be compliant with the /api/v1/check/add method in
    https://github.com/grafana/synthetic-monitoring-api-go-client/blob/main/docs/API.md
  EOF
  type        = list(string)
  default     = []
}
