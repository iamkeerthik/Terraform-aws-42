# # resource "kubernetes_service_account" "lbc_service_account" {
# #   metadata {
# #     name = "aws-load-balancer-controller"
# #     namespace = "kube-system"
# #   }
# # }
# # data "http" "aws_load_balancer_controller_iam_policy" {
# #   url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
# # }

# # resource "aws_iam_policy" "aws_load_balancer_controller_policy" {
# #   name        = "${var.name}-AWSLoadBalancerControllerIAMPolicy"
# #   path        = "/"
# #   description = "IAM policy for AWS Load Balancer Controller"

# #   policy = jsonencode(data.http.aws_load_balancer_controller_iam_policy.body)
# # }

# resource "aws_iam_role" "aws_load_balancer_controller_role" {
#   name = "${var.name}-AWSLoadBalancerControllerRole"
#   path = "/"
  
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })

#   # tags = {
#   #   Environment = var.environment
#   # }
# }

# resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_attachment" {
#   policy_arn = data.aws_iam_policy.lbcIAMPolicy.arn
#   role       = aws_iam_role.aws_load_balancer_controller_role.name
# }

# provider "kubernetes" {
#   host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
#   cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_ca_cert)
#   exec {
#     api_version = "client.authentication.k8s.io/v1alpha1"
#     args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_name]
#     command     = "aws"
#   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
#     cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_ca_certt)
#     exec {
#       api_version = "client.authentication.k8s.io/v1alpha1"
#       args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_name]
#       command     = "aws"
#     }
#   }
# }

# resource "kubernetes_service_account" "service-account" {
#   metadata {
#     name = "aws-load-balancer-controller"
#     namespace = "kube-system"
#     labels = {
#         "app.kubernetes.io/name"= "aws-load-balancer-controller"
#         "app.kubernetes.io/component"= "controller"
#     }
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.aws_load_balancer_controller_role.arn
#       "eks.amazonaws.com/sts-regional-endpoints" = "true"
#     }
#   }
# }

# resource "helm_release" "lb" {
#   name       = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"
#   depends_on = [
#     kubernetes_service_account.service-account
#   ]

#   set {
#     name  = "region"
#     value = var.region
#   }

#   set {
#     name  = "vpcId"
#     value = data.terraform_remote_state.eks.outputs.vpc_id
#   }

#   set {
#     name  = "image.repository"
#     value = "602401143452.dkr.ecr.eu-west-2.amazonaws.com/amazon/aws-load-balancer-controller"
#   }

#   set {
#     name  = "serviceAccount.create"
#     value = "false"
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = "aws-load-balancer-controller"
#   }

#   set {
#     name  = "clusterName"
#     value =  data.terraform_remote_state.eks.outputs.cluster_name
#   }
# }
# # # Resource: Helm Release 
# # resource "helm_release" "loadbalancer_controller" {
# #   depends_on = [aws_iam_role.aws_load_balancer_controller_role]
# #   name       = "aws-load-balancer-controller"

# #   repository = "https://aws.github.io/eks-charts"
# #   chart      = "aws-load-balancer-controller"

# #   namespace = "kube-system"

# #   set {
# #     name  = "image.repository"
# #     value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller" # Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
# #   }

# #   set {
# #     name  = "serviceAccount.create"
# #     value = "true"
# #   }

# #    set {
# #     name  = "serviceAccount.name"
# #     value = "aws-load-balancer-controller"
# #   }

# #   set {
# #     name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
# #     value = aws_iam_role.aws_load_balancer_controller_role.arn
# #   }

# #   set {
# #     name  = "vpcId"
# #     value = "${data.terraform_remote_state.eks.outputs.vpc_id}"
# #   }

# #   set {
# #     name  = "region"
# #     value = var.region
# #   }

# #   set {
# #     name  = "clusterName"
# #     value ="${var.name}-eks-cluster"
# #   }

# # }