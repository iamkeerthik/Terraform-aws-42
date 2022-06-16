resource "aws_s3_bucket" "s3_bucket" {
  bucket = "kirik-s3-bucket-test"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}