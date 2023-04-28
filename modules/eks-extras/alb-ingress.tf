
resource "kubernetes_service_account" "service-account" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
        "app.kubernetes.io/name"= "aws-load-balancer-controller"
        "app.kubernetes.io/component"= "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" = data.aws_iam_role.lbc_role.arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

resource "helm_release" "controller" {
  name       = "eks"
  namespace = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  # values = [
  #   file("${path.module}/values.yaml")
  #   # {
  #   # serviceAccount = {
  #   # create = false
  #   # name   = "aws-load-balancer-controller"
  #   # }
  #   # }
    
  # ]
  
  set {
    name  = "clusterName"
    value = "Terraform-eks-cluster"
  }
  set {
  name  = "serviceAccount.create"
  value = "false"
 }

set {
  name  = "serviceAccount.name"
  value = "aws-load-balancer-controller"
}
  
  set {
    name  = "replicaCount"
    value = "1"
  }
 depends_on = [
   kubernetes_service_account.service-account
 ]
}