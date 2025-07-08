locals {
  organization_root_id = "r-0000"
}

unit "accounts" {
  source = "../../../unit/accounts"
  path   = "accounts"

  values = {
    organizational_units_path = "../organizational-units"

    accounts = {
      "production" = {
        email             = "production@example.com"
        close_on_deletion = true
      }
      "monitoring" = {
        email             = "monitoring@example.com"
        close_on_deletion = true
      }
      "development" = {
        email             = "development@example.com"
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