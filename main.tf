locals {
  # only lowercase alphanumeric characters and hyphens allowed in s3 bucket name
  green_s3_origin_bucket = "${replace(var.naming_prefix, "_", "-")}-green"
}

resource "aws_s3_bucket" "green" {
  bucket        = local.green_s3_origin_bucket
  acl           = "private"
  force_destroy = true
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.green.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.cf_origin_access_identity_iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.green.arn}"]

    principals {
      type        = "AWS"
      identifiers = [var.cf_origin_access_identity_iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "green" {
  bucket = aws_s3_bucket.green.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_route53_record" "green" {
  zone_id = var.r53_zone_id
  name    = var.green_r53_name
  type    = "A"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = true
  }
}
