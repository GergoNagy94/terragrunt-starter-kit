terraform {
  source = "git::https://github.com/blackbird-cloud/terraform-aws-organization.git//modules/accounts/.?ref=v3.1.0"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  organization_units = {
    "monitoring" = {
      name      = "monitoring"
      parent_id = values.organization_root_id
      tags      = values.tags
    }
    "production" = {
      name      = "production"
      parent_id = values.organization_root_id
      tags      = values.tags
    }
    "development" = {
      name      = "development"
      parent_id = values.organization_root_id
      tags      = values.tags
    }
  }
}

skip = values.skip_module.organization_units

