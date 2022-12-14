# resource "aws_launch_template" "suredm_eks_launch_template" {
#   name = "your_eks_launch_template"

#   vpc_security_group_ids = [var.your_security_group.id, aws_eks_cluster.your-eks-cluster.vpc_config[0].cluster_security_group_id]

#   block_device_mappings {
#     device_name = "/dev/xvda"

#     ebs {
#       volume_size = 20
#       volume_type = "gp2"
#     }
#   }

#   image_id = "your_ami_value"
#   instance_type = "t3.medium"
#   user_data = base64encode(<<-EOF
# MIME-Version: 1.0
# Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="
# --==MYBOUNDARY==
# Content-Type: text/x-shellscript; charset="us-ascii"
# #!/bin/bash
# /etc/eks/bootstrap.sh your-eks-cluster
# --==MYBOUNDARY==--\
#   EOF
#   )

#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#       Name = "EKS-MANAGED-NODE"
#     }
#   }
# }