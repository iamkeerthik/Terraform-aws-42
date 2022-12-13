module "vpc" {
  source = "../terraform-aws-vpc-module"
}
module "ec2" {
  source = "../terraform-aws-ec2-windows-module"
  depends_on = [
    module.vpc
  ]
}

# module "alb" {
#   source     = "../terraform-aws-alb-module"
#   subnet_ids = [module.vpc.public_subnet_1, module.vpc.public_subnet_2]
#   depends_on = [
#     module.vpc
#   ]

# }

# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key"
#     region = "us-east-1"
#   }
# }