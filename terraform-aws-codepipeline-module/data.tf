data "aws_s3_bucket" "keerthik-s3-bucket" {
  bucket = "keerthik-s3-bucket"
}

data "aws_iam_role" "iam_role_codepipeline" {
  name = "myweb_pipeline"
}