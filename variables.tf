variable "description" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#description"
  type        = string
  default     = null
}

variable "enable_state" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#state"
  type        = bool
  default     = true
}

variable "start_date" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#start_date"
  type        = string
  default     = null
}

variable "end_date" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#end_date"
  type        = string
  default     = null
}

variable "maximum_window_in_minutes" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#flexible_time_window"
  type        = number
  default     = 15
}

variable "schedule_expression" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
  default     = "rate(1 minute)"
}

variable "schedule_expression_timezone" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
  default     = "America/New_York"

}

variable "service_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}

variable "api_action" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}

variable "role_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#role_arn"
  type        = string
}

variable "input_parameters" {
  description = "input parameter payload for api"
  type        = string
  default     = <<EOF
{
  "key": "value",
  "key1": "value"
}
EOF
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-eventbridge"
}