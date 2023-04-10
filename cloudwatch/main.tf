terraform {
  backend "s3" {
    bucket  = "terraform-statefiles-keerthik"
    key     = "dev-test-env/cloudwatch-terraform.tfstate"
    region  = "ap-south-1"
    profile = "PS"
  }
}

module "Cloudwatch" {
  source = "../modules/terraform-cloudwacth"
  # depends_on = [
  #   module.ec2
  # ]
  name = var.name
}