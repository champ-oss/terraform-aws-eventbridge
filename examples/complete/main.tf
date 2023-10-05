provider "aws" {
  region = "us-east-2"
}

module "this" {
  source       = "../../"
  service_name = "s3"
  api_action   = "deleteBucket"
  role_arn     = aws_iam_role.this.arn
  input_parameters = {
    Bucket = module.s3.bucket
  }

  depends_on = [module.s3]
}

module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.40-137c64b"
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
