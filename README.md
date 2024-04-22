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
| [aws_ssm_parameter.sm_access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sm_api_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [grafana_cloud_access_policy.otlp](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.read_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy) | resource |
| [grafana_cloud_access_policy_token.otlp](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.read_only](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_access_policy_token.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_access_policy_token) | resource |
| [grafana_cloud_plugin_installation.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_plugin_installation) | resource |
| [grafana_cloud_stack.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack) | resource |
| [grafana_cloud_stack_service_account.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account) | resource |
| [grafana_cloud_stack_service_account_token.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/cloud_stack_service_account_token) | resource |
| [grafana_sso_settings.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/sso_settings) | resource |
| [grafana_synthetic_monitoring_installation.this](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/synthetic_monitoring_installation) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_sign_up"></a> [allow\_sign\_up](#input\_allow\_sign\_up) | Whether to allow new Grafana user creation through SAML login. If set to false, then only existing Grafana users can log in with SAML. | `bool` | `null` | no |
| <a name="input_assertion_attribute_email"></a> [assertion\_attribute\_email](#input\_assertion\_attribute\_email) | Friendly name or name of the attribute within the SAML assertion to use as the user email | `string` | `""` | no |
| <a name="input_assertion_attribute_groups"></a> [assertion\_attribute\_groups](#input\_assertion\_attribute\_groups) | Friendly name or name of the attribute within the SAML assertion to use as the user groups | `string` | `""` | no |
| <a name="input_assertion_attribute_login"></a> [assertion\_attribute\_login](#input\_assertion\_attribute\_login) | Friendly name or name of the attribute within the SAML assertion to use as the user login handle | `string` | `""` | no |
| <a name="input_assertion_attribute_name"></a> [assertion\_attribute\_name](#input\_assertion\_attribute\_name) | Friendly name or name of the attribute within the SAML assertion to use as the user name | `string` | `""` | no |
| <a name="input_assertion_attribute_role"></a> [assertion\_attribute\_role](#input\_assertion\_attribute\_role) | Friendly name or name of the attribute within the SAML assertion to use as the user roles | `string` | `""` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | Base64-encoded string for the SP X.509 certificate | `string` | `""` | no |
| <a name="input_create_read_only_token"></a> [create\_read\_only\_token](#input\_create\_read\_only\_token) | Whether to create a read-only token | `bool` | `false` | no |
| <a name="input_enable_otlp"></a> [enable\_otlp](#input\_enable\_otlp) | Whether to enable OpenTelemetry | `bool` | `false` | no |
| <a name="input_grafana_folders"></a> [grafana\_folders](#input\_grafana\_folders) | List of grafana folders to be created | `list(string)` | `[]` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Name of the hosted zone to contain the route53 record. If unspecified no route53 record is created. | `string` | `null` | no |
| <a name="input_idp_metadata_url"></a> [idp\_metadata\_url](#input\_idp\_metadata\_url) | URL for the IdP SAML metadata XML | `string` | `""` | no |
| <a name="input_install_synthetic_monitoring"></a> [install\_synthetic\_monitoring](#input\_install\_synthetic\_monitoring) | Whether to install synthetic monitoring | `bool` | n/a | yes |
| <a name="input_name_id_format"></a> [name\_id\_format](#input\_name\_id\_format) | The Name ID Format to request within the SAML assertion | `string` | `""` | no |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | List of plugins | <pre>list(object({<br>    plugin  = string<br>    version = string<br>  }))</pre> | `[]` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Base64-encoded string for the SP private key | `string` | `""` | no |
| <a name="input_region_slug"></a> [region\_slug](#input\_region\_slug) | Region slug to assign to this stack. Changing region will destroy the existing stack and create a new one in the desired region | `string` | `null` | no |
| <a name="input_role_values_admin"></a> [role\_values\_admin](#input\_role\_values\_admin) | List of comma- or space-separated roles which will be mapped into the Admin role | `string` | `""` | no |
| <a name="input_role_values_editor"></a> [role\_values\_editor](#input\_role\_values\_editor) | List of comma- or space-separated roles which will be mapped into the Editor role | `string` | `""` | no |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | Name of the route53 record | `string` | `null` | no |
| <a name="input_saml_enabled"></a> [saml\_enabled](#input\_saml\_enabled) | Define whether this configuration is enabled for the specified provider | `bool` | `false` | no |
| <a name="input_saml_name"></a> [saml\_name](#input\_saml\_name) | Display name for the saml configuration | `string` | `"SAML"` | no |
| <a name="input_signature_algorithm"></a> [signature\_algorithm](#input\_signature\_algorithm) | Signature algorithm used for signing requests to the IdP. Supported values are rsa-sha1, rsa-sha256, rsa-sha512 | `string` | `"rsa-sha256"` | no |
| <a name="input_single_logout"></a> [single\_logout](#input\_single\_logout) | Whether SAML Single Logout is enabled | `bool` | `null` | no |
| <a name="input_slug"></a> [slug](#input\_slug) | Subdomain that the Grafana instance will be available at (i.e. setting slug to empty string will make the instance available at `https://.grafana.net` | `string` | `null` | no |
| <a name="input_sso_provider"></a> [sso\_provider](#input\_sso\_provider) | The name of the SSO provider. Supported values: github, gitlab, google, azuread, okta, generic\_oauth, saml | `string` | `"saml"` | no |
| <a name="input_stack_description"></a> [stack\_description](#input\_stack\_description) | Description of stack | `string` | `null` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | Name of stack | `string` | `null` | no |
| <a name="input_url"></a> [url](#input\_url) | Custom URL for the Grafana instance. Should not be specified when passing `hosted_zone_name` | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->