variable "bucket_names" {
  type        = list(string)
  description = "The names of the S3 buckets to create for logs."
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix for the name of the S3 buckets to create for logs."
}