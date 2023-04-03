
resource "aws_s3_bucket" "logs" {
  for_each = toset(var.bucket_names)

  bucket = "${var.bucket_prefix}-${each.value}"

#   versioning {
#     enabled = true
#   }
#   lifecycle_rule {
#         id      = "log-retention"
#         prefix  = each.value
#         enabled = true

#         expiration {
#             days = 60
#         }
#     }
}

resource "aws_s3_bucket_lifecycle_configuration" "Expiry" {
  for_each = aws_s3_bucket.logs
  bucket = each.value.id

  rule {
    id      = "Expiry"
    status  = "Enabled"
    filter {
      prefix = "logs"
    }
    expiration {
      days = 60
    }
  }
}

resource "aws_s3_bucket_acl" "acl" {
  for_each = aws_s3_bucket.logs
  bucket = each.value.id
  acl    = "private"
 

  # Set the appropriate access control list for the bucket.
  # For example, grant read/write access to the bucket for a specific user or group.
#   grant {
#     id        = "USER_OR_GROUP_ID"
#     type      = "CanonicalUser|AmazonCustomerByEmail|Group"
#     permission = "READ|WRITE|FULL_CONTROL"
#   }

  # You can specify additional grants as needed.
}

resource "aws_s3_bucket_versioning" "versioning" {
   for_each = aws_s3_bucket.logs
  bucket = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}