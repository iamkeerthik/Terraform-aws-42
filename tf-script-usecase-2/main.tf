module "codebuild" {
    source = "../terraform-aws-codebuild-module"
    codebuild_project_name = var.codebuild_project_name
    depends_on = [
      module.codepipeline
    ]
}
module "codedeploy" {
    source = "../terraform-aws-codedeploy-module"
    ec2_name = var.ec2_name
    depends_on = [
      module.codepipeline
    ]
}
module "codepipeline" {
    source = "../terraform-aws-codepipeline-module"
    codebuild_project_name = var.codebuild_project_name
}