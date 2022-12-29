output "cluster_role_name" {
    value = aws_iam_role.cluster_role.name
}

output "worker_role_name" {
    value = aws_iam_role.workernode_role.name
}

output "msk_role_name" {
    value = aws_iam_role.msk_role.name
}