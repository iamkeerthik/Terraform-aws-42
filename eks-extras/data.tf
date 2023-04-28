data "terraform_remote_state" "eks" {
   backend = "s3"
   config = {
    bucket  = "terraform-statefiles-keerthik"
    key     = "dev-test-env/infra-terraform.tfstate"
    region  = "ap-south-1"
    profile = "PS"
  }
}