terraform {
  source = "git::https://github.com/ganexcloud/terraform-aws-budget.git//.?ref=v2.0.0"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  name              = values.budget_name
  budget_type       = values.budget_type
  limit_amount      = values.budget_limit_amount
  limit_unit        = values.budget_limit_unit
  time_unit         = values.budget_time_unit
  time_period_start = values.budget_time_period_start
  cost_types        = values.budget_cost_types
  cost_filters      = values.cost_filters
  notifications = [
    {
      comparison_operator        = "GREATER_THAN"
      threshold                  = 80
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = values.budget_subscriber_email_addresses
    }
  ]

}

skip = values.skip_module.budget
