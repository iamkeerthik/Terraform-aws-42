# resource "kubernetes_service_account" "lbc" {
#   metadata {
#     name = "aws-load-balancer-controller"
#     namespace   ="kube-system"
#         annotations = {
#             "eks.amazonaws.com/role-arn" = data.aws_iam_role.lbc_role.arn
#         }
#   }
# }