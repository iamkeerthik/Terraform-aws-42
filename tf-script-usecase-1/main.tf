module "vpc" {
  source = "../terraform-aws-vpc-module"
}
module "ec2" {
  source = "../terraform-aws-ec2-module"
  depends_on = [
    module.vpc
  ]
}
module "rds" {
  source = "../terraform-aws-rds-module"
  depends_on = [
    module.ec2
  ]
}

# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key"
#     region = "us-east-1"
#   }
# }