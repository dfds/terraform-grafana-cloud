locals {
  uid = var.uid == null ? random_uuid.this.value : var.uid
}

resource "random_uuid" "this" {
}

resource "grafana_folder" "this" {
  title = var.title
  uid   = local.uid
}
