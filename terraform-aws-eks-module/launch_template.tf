# resource "aws_launch_template" "node_group_launch_template" {
#   name = "node-group-launch-template"

#   image_id      = "ami-03d748ca3502b6799"
#   instance_type = "t3a.medium"

#   user_data = base64encode(<<EOF
# #!/bin/bash
# echo ECS_CLUSTER=${aws_eks_cluster.suremdm-eks.name} >> /etc/ecs/ecs.config
# EOF
# )

#   iam_instance_profile {
#     name = "node-group-instance-profile"
#   }

#   key_name = "keerthik"

#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs {
#       volume_size = 20
#       volume_type = "gp2"
#       delete_on_termination = true
#     }
#   }

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "node-group-instance"
#     }
#   }
# }
