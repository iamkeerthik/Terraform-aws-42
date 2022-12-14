resource "aws_eks_cluster" "suremdm-eks" {
 name = "suremdm-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = [data.aws_subnet.public_1.id, data.aws_subnet.public_2.id]
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}