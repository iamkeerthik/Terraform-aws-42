# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12"
    }
  }
}
provider "aws" {
  profile = "PS"
  region  = "ap-south-1"
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}

provider "helm" {

}
provider "kubernetes" {

}