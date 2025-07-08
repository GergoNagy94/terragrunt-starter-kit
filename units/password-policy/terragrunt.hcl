terraform {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-iam-account//.?ref=v3.0.0"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  create_accessanalyzer = values.create_access_analyzer
  tags                  = values.tags
}

skip = values.skip_module.password_policy