data "terraform_remote_state" "eks" {
   backend = "s3"
   config = {
    bucket  = "terraform-statefiles-keerthik"
    key     = "terraform/dev-test-env/"
    region  = "ap-south-1"
    profile = "PS"
  }
}

# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.suremdm-eks.identity.0.oidc.0.issuer
# }
