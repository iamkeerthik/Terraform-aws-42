output "eks_cluster_id" {
  value = aws_eks_cluster.suremdm-eks.id
}

output "eks_nodegroup_id" {
  value = aws_eks_node_group.worker-node-group.id
}