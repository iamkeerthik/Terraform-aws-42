variable "codebuild_project_name" {
  type = string
}
variable "log_group_name" {
  type        = string
  description = "log group name"
  default     = "log-group"
}
variable "log_stream_name" {
  type        = string
  description = "log stream name"
  default     = "log-stream"
}
variable "s3_bucket_log" {
  type        = string
  description = "s3 bucket name to store logs"
  default     = "	keerthik-s3-bucket"
}
variable "s3_bucket_artifact" {
  type        = string
  description = "s3 bucket to store artifacts"
  default     = "	keerthik-s3-bucket"
}
