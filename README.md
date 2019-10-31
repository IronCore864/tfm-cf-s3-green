# Terraform Module - S3 Bucket for CloudFront Green ENV in Blue/Green Deployment

Creates the Green part of a Blue/Green deployment of Cloudfront: R53 and S3.

## Usage

Example:

```
module "cf_s3_green_de" {
  source        = "git::https://github.com/IronCore864/tfm-cf-s3-green.git"
  naming_prefix = "xxx"
  cf_domain_name                    = "xxx"
  cf_hosted_zone_id                 = "xxx"
  r53_zone_id                       = var.r53_zone_id
  green_r53_name                    = var.green_r53_name
  routing_rules                     = var.routing_rules_green
  cf_origin_access_identity_iam_arn = "xxx"
}
```
