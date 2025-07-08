locals {
  account_id = "123456789012"
}

unit "budget" {
  source = "../../../unit/budget"
  path   = "budget"

  values = {
    budget_name              = "Monthly Budget"
    budget_type              = "COST"
    budget_limit_amount      = "50"
    budget_limit_unit        = "USD"
    budget_time_unit         = "MONTHLY"
    budget_time_period_start = "2024-08-01_15:00"
    cost_filters = [
      {
        name   = "LinkedAccount"
        values = ["${local.account_id}"]
      }
    ]
    budget_cost_types = {
      include_credit             = false
      include_discount           = true
      include_other_subscription = true
      include_recurring          = true
      include_refund             = false
      include_subscription       = true
      include_support            = true
      include_tax                = true
      include_upfront            = true

    }
    notifications = [
      {
        comparison_operator               = "GREATER_THAN"
        threshold                         = 80
        threshold_type                    = "PERCENTAGE"
        notification_type                 = "ACTUAL"
        budget_subscriber_email_addresses = ["monitoring@example.com"]
      }
    ]
  }
}

unit "password_policy" {
  source = "../../../unit/password_policy"
  path   = "password_policy"

  values = {
    create_accessanalyzer = false
  }
}