resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.suremdm-eks.name
  node_group_name = "suremdm-workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [data.aws_subnet.private_1.id, data.aws_subnet.private_2.id]
  instance_types = ["t3a.medium"]
 
  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }
