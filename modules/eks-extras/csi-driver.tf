# resource "kubernetes_service_account" "csi-service-account" {
#   metadata {
#     name = "aws-csi-driver"
#     namespace = "kube-system"
#     labels = {
#         "app.kubernetes.io/name"= "aws-csi-driver"
#         "app.kubernetes.io/component"= "driver"
#     }
#     annotations = {
#       "eks.amazonaws.com/role-arn" = data.aws_iam_role.csi_role.arn
#       "eks.amazonaws.com/sts-regional-endpoints" = "true"
#     }
#   }
#   # provisioner "local-exec" {
#   #   command = "eksctl create addon --name aws-ebs-csi-driver --cluster  ${data.terraform_remote_state.eks.outputs.cluster_name} --region ${var.region} --service-account-role-arn ${data.aws_iam_role.csi_role.arn} --force"
#   # }
# }

# resource "aws_eks_addon" "aws_ebs_csi_driver" {
#   cluster_name = data.terraform_remote_state.eks.outputs.cluster_name
#   addon_name   = "ebs-csi-driver"
#   addon_version = "v1.18.0-eksbuild.1"
#   service_account_role_arn = data.aws_iam_role.csi_role.arn
# }

resource "helm_release" "ebs_csi_driver" {
  depends_on = [aws_iam_role.ebs_csi_iam_role]
  name       = "aws-ebs-csi-driver"

  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  # version    = # leave blank to use the latest

  namespace = "kube-system"

  # set {
  #   name = "image.repository"
  #   value = "6602401143452.dkr.ecr.ap-south-1.amazonaws.com" # Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  # }

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }
  
  set {
    name  = "replicaCount"
    value = "1"
  }
  set {
    name  = "controller.serviceAccount.name"
    value = "ebs-csi-controller-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.lbc_iam_role.arn}"
  }
}