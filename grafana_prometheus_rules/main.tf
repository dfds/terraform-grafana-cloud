resource "terraform_data" "this" {
  count = length(var.prometheus_rule_files)

  triggers_replace = {
    always_run = filemd5(var.prometheus_rule_files[count.index]) # Only run when the file changes
  }

  provisioner "local-exec" {
    command = "mimirtool rules load --address=${var.prometheus_url} --id=${var.prometheus_user_id} --key=${var.rules_management_access_token} ${var.prometheus_rule_files[count.index]}"
  }
}
