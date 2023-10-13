locals {
  # https://github.com/hashicorp/terraform/pull/18871
  input_parameters = replace(replace(jsonencode(var.input_parameters),
    "\\u003e", ">"),
  "\\u003c", "<")
}

resource "aws_scheduler_schedule" "universal_target" {
  count = var.enable_resources ? 1 : 0

  name_prefix = "${var.git}-"
  description = var.description
  state       = var.enable_state ? "ENABLED" : "DISABLED"
  start_date  = var.start_date
  end_date    = var.end_date

  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = var.maximum_window_in_minutes
  }

  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_expression_timezone

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:${var.service_name}:${var.api_action}"
    role_arn = var.role_arn
    input    = local.input_parameters
  }
}
