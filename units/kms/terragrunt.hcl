terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-kms.git?ref=v3.1.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  aliases                  = ["${values.locals.env}-${values.locals.project}"]
  description              = "KMS key for EKS cluster"
  customer_master_key_spec = values.locals.kms_customer_master_key_spec
  key_usage                = values.locals.kms_key_usage
  key_administrators       = values.locals.kms_key_administrators
  tags                     = values.locals.tags
}

skip = values.locals.skip_module.kms