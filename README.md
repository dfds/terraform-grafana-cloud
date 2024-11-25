<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.34.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | >= 3.13.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.14.0 |
| <a name="requirement_onepassword"></a> [onepassword](#requirement\_onepassword) | >= 2.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.route53"></a> [aws.route53](#provider\_aws.route53) | >= 5.34.0 |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | >= 3.13.2 |
| <a name="provider_grafana.cloud"></a> [grafana.cloud](#provider\_grafana.cloud) | >= 3.13.2 |
| <a name="provider_grafana.stack"></a> [grafana.stack](#provider\_grafana.stack) | >= 3.13.2 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_onepassword"></a> [onepassword](#provider\_onepassword) | >= 2.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ssm_parameter.grafana_cloud_stack_service_account_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_cloud_stack_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.otlp_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.otlp_user_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.prometheus_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.prometheus_user_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.read_only_multi_stack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.rules_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sm_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sm_api_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.write_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [grafana_cloud_access_policy.read_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.read_only_multi_stack](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.rules_management](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.write_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy_token.read_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.read_only_multi_stack](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.rules_management](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.write_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_plugin_installation.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_plugin_installation) | resource |
| [grafana_cloud_stack.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack) | resource |
| [grafana_cloud_stack_service_account.editor](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account) | resource |
| [grafana_cloud_stack_service_account.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account) | resource |
| [grafana_cloud_stack_service_account_token.editor](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account_token) | resource |
| [grafana_cloud_stack_service_account_token.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account_token) | resource |
| [grafana_role_assignment_item.editor](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/role_assignment_item) | resource |
| [grafana_role_assignment_item.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/role_assignment_item) | resource |
| [grafana_sso_settings.azuread](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/sso_settings) | resource |
| [grafana_sso_settings.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/sso_settings) | resource |
| [grafana_synthetic_monitoring_installation.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/synthetic_monitoring_installation) | resource |
| [grafana_team.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/team) | resource |
| [helm_release.otel_collector](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.ingress_route](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.middleware](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [onepassword_item.stack_vault_item](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/resources/item) | resource |
| [random_password.collector_token](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/password) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [grafana_cloud_stack.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/cloud_stack) | data source |
| [grafana_role.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_read_only_token"></a> [create\_read\_only\_token](#input\_create\_read\_only\_token) | Whether to create a read-only token | `bool` | `false` | no |
| <a name="input_create_rules_management_token"></a> [create\_rules\_management\_token](#input\_create\_rules\_management\_token) | Whether to create a rules management token | `bool` | `false` | no |
| <a name="input_create_write_only_token"></a> [create\_write\_only\_token](#input\_create\_write\_only\_token) | Whether to create a write-only token | `bool` | `false` | no |
| <a name="input_deploy_otel_agent_k8s"></a> [deploy\_otel\_agent\_k8s](#input\_deploy\_otel\_agent\_k8s) | Whether to deploy the OpenTelemetry agent into a Kubernetes cluster | `bool` | `false` | no |
| <a name="input_enable_collector_for_external_access"></a> [enable\_collector\_for\_external\_access](#input\_enable\_collector\_for\_external\_access) | Whether to enable external access to the OpenTelemetry agent from outside the Kubernetes cluster | `bool` | `false` | no |
| <a name="input_enable_sso_azuread"></a> [enable\_sso\_azuread](#input\_enable\_sso\_azuread) | Enable SSO Azure AD | `bool` | `false` | no |
| <a name="input_enable_sso_saml"></a> [enable\_sso\_saml](#input\_enable\_sso\_saml) | Enable SSO SAML | `bool` | `false` | no |
| <a name="input_grafana_folders"></a> [grafana\_folders](#input\_grafana\_folders) | List of grafana folders to be created | `list(string)` | `[]` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Name of the hosted zone to contain the route53 record. If unspecified no route53 record is created. | `string` | `null` | no |
| <a name="input_install_synthetic_monitoring"></a> [install\_synthetic\_monitoring](#input\_install\_synthetic\_monitoring) | Whether to install synthetic monitoring | `bool` | n/a | yes |
| <a name="input_onepassword_vault_id"></a> [onepassword\_vault\_id](#input\_onepassword\_vault\_id) | The ID of the vault to store the stack information in | `string` | n/a | yes |
| <a name="input_otel_collector_chart_version"></a> [otel\_collector\_chart\_version](#input\_otel\_collector\_chart\_version) | Version of the Open Telemetry collector helm chart to deploy | `string` | `null` | no |
| <a name="input_otel_collector_namespace"></a> [otel\_collector\_namespace](#input\_otel\_collector\_namespace) | Namespace to deploy the OpenTelemetry agent into | `string` | `"grafana"` | no |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | List of plugins | <pre>list(object({<br/>    plugin  = string<br/>    version = string<br/>  }))</pre> | `[]` | no |
| <a name="input_region_slug"></a> [region\_slug](#input\_region\_slug) | Region slug to assign to this stack. Changing region will destroy the existing stack and create a new one in the desired region | `string` | `null` | no |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | Name of the route53 record | `string` | `null` | no |
| <a name="input_service_account_editor_permissions"></a> [service\_account\_editor\_permissions](#input\_service\_account\_editor\_permissions) | List of permissions for the service account for stack editors | `list(string)` | n/a | yes |
| <a name="input_slug"></a> [slug](#input\_slug) | Subdomain that the Grafana instance will be available at (i.e. setting slug to empty string will make the instance available at `https://.grafana.net` | `string` | `null` | no |
| <a name="input_sso_azuread_auth_url"></a> [sso\_azuread\_auth\_url](#input\_sso\_azuread\_auth\_url) | OAuth 2.0 authorization endpoint (v2) for SSO Azure AD | `string` | `""` | no |
| <a name="input_sso_azuread_client_id"></a> [sso\_azuread\_client\_id](#input\_sso\_azuread\_client\_id) | Application ID of the Azure AD application | `string` | `""` | no |
| <a name="input_sso_azuread_client_secret"></a> [sso\_azuread\_client\_secret](#input\_sso\_azuread\_client\_secret) | Client secret of the Azure AD application | `string` | `""` | no |
| <a name="input_sso_azuread_token_url"></a> [sso\_azuread\_token\_url](#input\_sso\_azuread\_token\_url) | OAuth 2.0 token endpoint (v2) for SSO Azure AD | `string` | `""` | no |
| <a name="input_sso_saml_assertion_attribute_role"></a> [sso\_saml\_assertion\_attribute\_role](#input\_sso\_saml\_assertion\_attribute\_role) | The attribute to use for role mapping | `string` | `""` | no |
| <a name="input_sso_saml_certificate"></a> [sso\_saml\_certificate](#input\_sso\_saml\_certificate) | Base64-encoded certificate | `string` | `""` | no |
| <a name="input_sso_saml_idp_metadata_url"></a> [sso\_saml\_idp\_metadata\_url](#input\_sso\_saml\_idp\_metadata\_url) | The URL to the IDP metadata | `string` | `""` | no |
| <a name="input_sso_saml_private_key"></a> [sso\_saml\_private\_key](#input\_sso\_saml\_private\_key) | Base64-encoded private key | `string` | `""` | no |
| <a name="input_sso_saml_role_values_admin"></a> [sso\_saml\_role\_values\_admin](#input\_sso\_saml\_role\_values\_admin) | List of comma- or space-separated roles which will be mapped into the Admin role used in the saml response | `string` | `""` | no |
| <a name="input_sso_saml_role_values_editor"></a> [sso\_saml\_role\_values\_editor](#input\_sso\_saml\_role\_values\_editor) | List of comma- or space-separated roles which will be mapped into the Viewer role used in the saml response | `string` | `""` | no |
| <a name="input_sso_saml_role_values_viewer"></a> [sso\_saml\_role\_values\_viewer](#input\_sso\_saml\_role\_values\_viewer) | List of comma- or space-separated roles which will be mapped into the Viewer role used in the saml response | `string` | `""` | no |
| <a name="input_stack_description"></a> [stack\_description](#input\_stack\_description) | Description of stack | `string` | `null` | no |
| <a name="input_stack_labels"></a> [stack\_labels](#input\_stack\_labels) | Map of labels to apply to the stack | `map(string)` | `{}` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | Name of stack | `string` | `null` | no |
| <a name="input_stacks_for_multi_stack_querying"></a> [stacks\_for\_multi\_stack\_querying](#input\_stacks\_for\_multi\_stack\_querying) | List of stacks to create access token for multiple stacks | `list(string)` | `[]` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | List of teams to create with the groups and permissions | <pre>list(object({<br/>    name        = string<br/>    groups      = list(string)<br/>    permissions = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_url"></a> [url](#input\_url) | Custom URL for the Grafana instance. Should not be specified when passing `hosted_zone_name` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_url"></a> [grafana\_url](#output\_grafana\_url) | n/a |
| <a name="output_read_only_multi_stack_token"></a> [read\_only\_multi\_stack\_token](#output\_read\_only\_multi\_stack\_token) | n/a |
| <a name="output_stack_logs_url"></a> [stack\_logs\_url](#output\_stack\_logs\_url) | n/a |
| <a name="output_stack_otlp_id"></a> [stack\_otlp\_id](#output\_stack\_otlp\_id) | n/a |
| <a name="output_stack_otlp_url"></a> [stack\_otlp\_url](#output\_stack\_otlp\_url) | n/a |
| <a name="output_stack_prometheus_url"></a> [stack\_prometheus\_url](#output\_stack\_prometheus\_url) | n/a |
| <a name="output_stack_slug"></a> [stack\_slug](#output\_stack\_slug) | n/a |
| <a name="output_stack_traces_url"></a> [stack\_traces\_url](#output\_stack\_traces\_url) | n/a |
| <a name="output_terraform_sa_token"></a> [terraform\_sa\_token](#output\_terraform\_sa\_token) | n/a |
| <a name="output_write_only_token"></a> [write\_only\_token](#output\_write\_only\_token) | n/a |
<!-- END_TF_DOCS -->