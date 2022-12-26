# # Create a Project
# resource "mongodbatlas_project" "atlas-project" {
#   org_id = var.atlas_org_id
#   name = var.atlas_project_name
# }

module "cluster" {
  source        = "../modules/mongo-cluster"
  project_id    = var.project_id
  region        = var.region
  cloud_provider = var.cloud_provider
  cluster_name  = var.cluster_name
  cluster_size  = var.cluster_size
  disk_size_gb = var.disk_size_gb
  mongodb_version = var.mongodb_version
  

}
