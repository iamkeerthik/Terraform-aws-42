resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.suremdm-eks.name
  node_group_name = "suremdm-workernodes"
  node_role_arn   = data.aws_iam_role.node_role.arn
  subnet_ids      = [data.aws_subnet.public_1.id, data.aws_subnet.public_2.id]
  # security_groups = [data.aws_security_group.eks-security.id]
  instance_types  = ["t2.micro"] #using launch template
  

  tags = {
    Name        = "${var.cluster_name}-Nodegroup"
    Environment = var.cluster_name
  }
  
  scaling_config {
    desired_size = var.asg_desired_size
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }
  
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }
  
}
