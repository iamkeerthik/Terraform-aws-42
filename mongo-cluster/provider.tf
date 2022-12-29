# # Define the MongoDB Atlas Provider
# terraform {
#   required_providers {
#     mongodbatlas = {
#       source = "mongodb/mongodbatlas"
#     }
#   }
#   required_version = ">= 0.13"
# }

provider "mongodbatlas" {
  public_key = "<YOUR PUBLIC KEY HERE>"
  private_key  = "<YOUR PRIVATE KEY HERE>"
}