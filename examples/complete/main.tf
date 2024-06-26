terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

module "this" {
  source                    = "../../"
  service_name              = "s3"
  api_action                = "deleteBucket"
  role_arn                  = aws_iam_role.this.arn
  maximum_window_in_minutes = 1
  input_parameters = {
    Bucket = module.s3.bucket
  }

  depends_on = [module.s3]
}

module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.48-73aadca"
  git     = "terraform-aws-eventbridge"
  protect = false
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "sts" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com", "scheduler.amazonaws.com"]
    }

  }
}

resource "aws_iam_role" "this" {
  name_prefix        = substr("tf-aws-eventbridge-schedule-", 0, 38) # 38 max length
  assume_role_policy = data.aws_iam_policy_document.sts.json
}

resource "aws_iam_policy" "this" {
  name_prefix = "tf-aws-eventbridge-s3-eventbridge-"
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}

output "s3_bucket" {
  description = "s3 bucket to search for in test"
  value       = module.s3.bucket
}
