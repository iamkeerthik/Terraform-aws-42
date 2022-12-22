resource "aws_eks_cluster" "suremdm-eks" {
  name     = var.cluster_name
  # version = "1.23"
  role_arn = data.aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids =[data.aws_subnet.public_1.id, data.aws_subnet.public_2.id]
    security_group_ids = [data.aws_security_group.eks-security.id]
  }

}