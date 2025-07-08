terraform {
  source = "git::https://github.com/blackbird-cloud/terraform-aws-organization.git//modules/accounts?ref=v3.0.5"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  accounts = {
    "production" = {
      email                            = values.production_account_email
      delegated_administrator_services = []
      parent_id                        = dependency.organizational-units.outputs.ous["production"].id
      close_on_deletion                = values.account_close_on_deletion
    }
    "monitoring" = {
      email                            = values.monitoring_account_email
      delegated_administrator_services = []
      parent_id                        = dependency.organizational-units.outputs.ous["monitoring"].id
      close_on_deletion                = values.account_close_on_deletion
    }
    "development" = {
      email                            = values.development_account_email
      delegated_administrator_services = []
      parent_id                        = dependency.organizational-units.outputs.ous["development"].id
      close_on_deletion                = values.account_close_on_deletion
    }
  }
  contacts = {
    primary_contact    = values.org_primary_contact
    billing_contact    = values.org_billing_contact
    security_contact   = values.org_security_contact
    operations_contact = values.org_operations_contact
  }
  tags = values.tags
}

dependency "organizational-units" {
  config_path = values.organizational_units_path

  mock_outputs = {
    ous = {
      "production" = {
        id = "000000"
      }
      "monitoring" = {
        id = "000000"
      }
      "development" = {
        id = "000000"
      }
    }
  }
}

skip = values.skip_module.accounts

