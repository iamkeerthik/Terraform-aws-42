# Define the MongoDB Atlas Provider
terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      veversion = "1.5.0"
    }
  }
  required_version = ">= 0.13"
}

