data "terraform_remote_state" "ec2" {
   backend = "s3"
   config = {
    bucket  = "terraform-statefiles-keerthik"
    key     = "dev-test-env/terraform.tfstate"
    region  = "ap-south-1"
    profile = "PS"
  }
}

data "aws_sns_topic" "ec2_topic" {
  name = "EC2-topic"
}
# data "aws_instances" "pluto" {
#  filter {
#     name   = "tag:Name"
#     values = ["${lower(var.name)}-pluto-server"]
#   }
# }

# data "aws_instances" "db" {
#  filter {
#     name   = "tag:Name"
#     values = ["${lower(var.name)}-db-server"]
#   }
# }

# data "aws_instances" "public" {
#   filter {
#     name   = "tag:Name"
#     values = ["${lower(var.name)}-public-server"]
#   }
# }

# data "aws_instances" "ec2_instance_ids" {
#   filter {
#     name   = "tag:Name"
#     values = ["${lower(var.name)}-public-server"]
#   }
# }