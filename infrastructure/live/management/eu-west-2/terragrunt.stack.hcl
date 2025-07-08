locals {
  project         = "example"
  project_version = "v1.0.0"

  organization_id      = "o-0000000000"
  organization_root_id = "r-0000"

  management_account_id  = "012345678910"
  monitoring_account_id  = "012345678910"
  production_account_id  = "012345678910"
  development_account_id = "012345678910"

  management_account_email  = "management@example.com"
  monitoring_account_email  = "monitoring@example.com"
  production_account_email  = "production@example.com"
  development_account_email = "development@example.com"
}

unit "accounts" {
  source                    = "../../../unit/accounts"
  path                      = "accounts"
  organizational_units_path = "../organizational-units"

  values = {
    accounts = {
      "production" = {
        email             = local.production_account_email
        close_on_deletion = true
      }
      "monitoring" = {
        email             = local.monitoring_account_email
        close_on_deletion = true
      }
      "development" = {
        email             = local.development_account_email
        close_on_deletion = true
      }
    }
    contacts = {
      org_primary_contact = = {
        address_line_1  = "110 Maplewood Avenue, Apartment 5B"
        city            = "Springfield"
        country_code    = "USA"
        full_name       = "Emily Harper"
        phone_number    = "+12345678910"
        postal_code     = "1234"
        state_or_region = "California"
      }
      org_billing_contact = {
        name          = "Liam Chen"
        title         = "Billing"
        email_address = "liam.chen@example.com"
        phone_number  = "+12345678910"
      }
      org_operations_contact = {
        name          = "Sophie Martínez"
        title         = "Operations"
        email_address = "sophie.martínez@example.com"
        phone_number  = "+12345678910"
      }
      org_security_contact = {
        name          = "Arjun Patel"
        title         = "Security"
        email_address = "arjun.patel@example.com"
        phone_number  = "+12345678910"
      }
    }
  }
}

unit "organizational-units" {
  source = "../../../unit/organizational-units"
  path   = "organizational-units"

  values = {
    organizational_units = {
      "monitoring" = {
        parent_id = local.organization_root_id
      }
      "production" = {
        parent_id = local.organization_root_id
      }
      "development" = {
        parent_id = local.organization_root_id
      }
    }
  }
}