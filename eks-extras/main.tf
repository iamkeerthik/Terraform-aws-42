module "eks-extra" {
  source = "../modules/eks-extras"
  region = var.region
  name = var.name
}