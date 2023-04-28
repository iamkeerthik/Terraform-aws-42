data "aws_iam_role" "lbc_role" {
  name = "AmazonEKSLoadBalancerControllerRoleTerraform"

}
# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.suremdm-eks.identity.0.oidc.0.issuer
# }
data "terraform_remote_state" "eks" {
   backend = "s3"
   config = {
    bucket  = "terraform-statefiles-keerthik"
    key     = "dev-test-env/infra-terraform.tfstate"
    region  = "ap-south-1"
    profile = "PS"
  }
}