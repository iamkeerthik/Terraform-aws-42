variable "project_id" {}
variable "cluster_name" {}
variable "cluster_size" {}
variable "region" {
  default = "EU_CENTRAL_1"
}
variable "cloud_provider" {}
variable "disk_size_gb" {}
variable "mongodb_version" {}
variable "no_of_shrads" {}

resource "mongodbatlas_cluster" "cluster" {
  project_id   = var.project_id // Your mongodb atlas project id
  name         = var.cluster_name // Desired cluster name
  disk_size_gb = var.disk_size_gb // Disk size: Choose based on the instance size flavour you want. For ex, for M10, it's 10GB
  num_shards   = var.no_of_shrads
  auto_scaling_compute_enabled = true
  auto_scaling_compute_scale_down_enabled = true

  auto_scaling_disk_gb_max = 500
  auto_scaling_compute_min = 1
  auto_scaling_compute_max = 10
  
  replication_factor           = 3
  provider_backup_enabled      = false
  auto_scaling_disk_gb_enabled = false
  mongo_db_major_version = var.mongodb_version

  //Provider Settings "block"
  provider_name               = var.cloud_provider // Could be GCP | AWS | AZURE
  provider_disk_iops          = 100
  provider_volume_type        = "STANDARD"
  provider_encrypt_ebs_volume = true
  provider_instance_size_name = var.cluster_size // Could be anything above M2. M0 is not supported via this provider
  provider_region_name        = var.region // Desired region
}