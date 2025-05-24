terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "multi-terra-staging-state-bucket-tf"
    region  = "us-east-1"
    key     = "staging/terraform.tfstate"
    encrypt = true
    profile = var.profile
  }

}

provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_s3_bucket" "terraform_state-staging" {
  bucket = var.state_bucket

  lifecycle {
    prevent_destroy = true
  }
}