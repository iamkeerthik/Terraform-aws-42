
module "vpc" {
  source = "../terraform-aws-vpc-module"
}
# module "ec2" {
#   source = "../terraform-aws-ec2-windows-module"
#   depends_on = [
#     module.vpc
#   ]
# }

module "eks" {
  source = "../terraform-aws-eks-module"
  depends_on = [
    module.vpc
  ]
}

# module "MSK" {
#   source = "../terraform-aws-msk-module"
#   depends_on = [
#     module.vpc
#   ]
  
# }