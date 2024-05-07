<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.34.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | >= 2.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.route53"></a> [aws.route53](#provider\_aws.route53) | >= 5.34.0 |
| <a name="provider_grafana.cloud"></a> [grafana.cloud](#provider\_grafana.cloud) | >= 2.9.0 |
| <a name="provider_grafana.stack"></a> [grafana.stack](#provider\_grafana.stack) | >= 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ssm_parameter.grafana_cloud_stack_service_account_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_cloud_stack_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.otlp_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.read_only_multi_stack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sm_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sm_api_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [grafana_cloud_access_policy.otlp](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.read_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.read_only_multi_stack](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy_token.otlp](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.read_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.read_only_multi_stack](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_plugin_installation.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_plugin_installation) | resource |
| [grafana_cloud_stack.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack) | resource |
| [grafana_cloud_stack_service_account.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account) | resource |
| [grafana_cloud_stack_service_account_token.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account_token) | resource |
| [grafana_role_assignment_item.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/role_assignment_item) | resource |
| [grafana_synthetic_monitoring_installation.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/synthetic_monitoring_installation) | resource |
| [grafana_team.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/team) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [grafana_cloud_stack.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/cloud_stack) | data source |
| [grafana_role.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_read_only_token"></a> [create\_read\_only\_token](#input\_create\_read\_only\_token) | Whether to create a read-only token | `bool` | `false` | no |
| <a name="input_enable_otlp"></a> [enable\_otlp](#input\_enable\_otlp) | Whether to enable OpenTelemetry | `bool` | `false` | no |
| <a name="input_grafana_folders"></a> [grafana\_folders](#input\_grafana\_folders) | List of grafana folders to be created | `list(string)` | `[]` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Name of the hosted zone to contain the route53 record. If unspecified no route53 record is created. | `string` | `null` | no |
| <a name="input_install_synthetic_monitoring"></a> [install\_synthetic\_monitoring](#input\_install\_synthetic\_monitoring) | Whether to install synthetic monitoring | `bool` | n/a | yes |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | List of plugins | <pre>list(object({<br>    plugin  = string<br>    version = string<br>  }))</pre> | `[]` | no |
| <a name="input_region_slug"></a> [region\_slug](#input\_region\_slug) | Region slug to assign to this stack. Changing region will destroy the existing stack and create a new one in the desired region | `string` | `null` | no |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | Name of the route53 record | `string` | `null` | no |
| <a name="input_slug"></a> [slug](#input\_slug) | Subdomain that the Grafana instance will be available at (i.e. setting slug to empty string will make the instance available at `https://.grafana.net` | `string` | `null` | no |
| <a name="input_stack_description"></a> [stack\_description](#input\_stack\_description) | Description of stack | `string` | `null` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | Name of stack | `string` | `null` | no |
| <a name="input_stacks_for_multi_stack_querying"></a> [stacks\_for\_multi\_stack\_querying](#input\_stacks\_for\_multi\_stack\_querying) | List of stacks to create access token for multiple stacks | `list(string)` | `[]` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | List of teams to create with the groups and permissions | <pre>list(object({<br>    name        = string<br>    groups      = list(string)<br>    permissions = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_url"></a> [url](#input\_url) | Custom URL for the Grafana instance. Should not be specified when passing `hosted_zone_name` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_read_only_multi_stack_token"></a> [read\_only\_multi\_stack\_token](#output\_read\_only\_multi\_stack\_token) | n/a |
<!-- END_TF_DOCS -->