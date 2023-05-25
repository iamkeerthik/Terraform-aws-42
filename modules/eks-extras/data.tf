data "terraform_remote_state" "eks" {
   backend = "s3"
   config = {
    bucket  = "terraform-statefiles-keerthik"
    key     = "dev-test-env/infra-terraform.tfstate"
    region  = "ap-south-1"
    profile = "PS"
  }
}


data "aws_iam_role" "lbc_role" {
  name = "AmazonEKSLoadBalancerControllerRole2"
}

data "aws_iam_role" "csi_role" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

}
# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.suremdm-eks.identity.0.oidc.0.issuer
# }

data "aws_iam_policy" "AmazonEBSCSIDriverPolicy" {
  name = "AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy" "lbcPolicy" {
  name = "AWSLoadBalancerControllerIAMPolicy"
}