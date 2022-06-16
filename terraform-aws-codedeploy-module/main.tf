resource "aws_codedeploy_app" "codedeploy_app" {
  compute_platform = var.compute_platform_target
  name             = var.codedeploy_app_name
  tags = {
    Name = var.codedeploy_app_tag_name
  }
}