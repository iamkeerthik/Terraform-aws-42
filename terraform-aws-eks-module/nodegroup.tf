resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.suremdm-eks.name
  node_group_name = "suremdm-workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [data.aws_subnet.public_1.id, data.aws_subnet.public_2.id]
  # instance_types = ["t3a.medium"] #using launch template
  # tags = merge(var.default_tags, map("Name", "suremdm-eks-ng"))
  tags = {
    Name = "suremdm-eks-ng"
  }

 scaling_config {
    desired_size = var.asg_desired_size
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }

  launch_template {
   name = var.launch_template_name
   version = var.launch_template_version
  }
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }
