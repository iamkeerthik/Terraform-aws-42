# Define the MongoDB Atlas Provider
terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      
    }
  }
  required_version = ">= 0.13"
}

provider "mongodbatlas" {
  public_key = "yfwkuffe"
  private_key  = "2fdc88f1-3a98-4002-afd9-88e2b3e5b331"
  version = "1.5.0"
}