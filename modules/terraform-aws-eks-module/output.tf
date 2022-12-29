output "eks_cluster_name" {
  value = aws_eks_cluster.suremdm-eks.name
}

output "eks_nodegroup_name" {
  value = aws_eks_node_group.worker-node-group.name
}