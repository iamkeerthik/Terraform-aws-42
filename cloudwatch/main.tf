module "Cloudwatch" {
  source = "../modules/terraform-cloudwacth"
  # depends_on = [
  #   module.ec2
  # ]
  name = var.name
}