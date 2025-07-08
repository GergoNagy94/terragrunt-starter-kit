terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks?ref=v5.57.0"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  role_name                     = values.ebs_csi_irsa_role_name
  attach_ebs_csi_policy         = values.ebs_csi_irsa_attach_ebs_csi_policy
  ebs_csi_kms_cmk_ids           = values.ebs_csi_irsa_ebs_csi_kms_cmk_ids
  external_secrets_kms_key_arns = values.ebs_csi_irsa_external_secrets_kms_key_arns
  oidc_providers = {
    main = {
      provider_arn               = dependency.eks.outputs.oidc_provider_arn
      namespace_service_accounts = values.ebs_csi_irsa_namespace_service_accounts
    }
  }
  tags = values.tags
}

dependency "eks" {
  config_path = values.eks_path

  mock_outputs = {
    oidc_provider_arn = "arn:::"
  }
}

skip = values.skip_module.ebs_csi_irsa