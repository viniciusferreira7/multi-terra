terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # backend "s3" { //TODO: It´s created before terraform init, and it search s3 remote
  #   bucket  = "multi-terra-dev-state-bucket-tf"
  #   region  = "us-east-1"
  #   key     = "dev/terraform.tfstate"
  #   encrypt = true
  #   profile = "vinicius.ferreira.dev"
  # }

}

provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

# resource "aws_s3_bucket" "terraform_state-dev" {
#   bucket = var.state_bucket

#   lifecycle {
#     prevent_destroy = true
#   }
# }