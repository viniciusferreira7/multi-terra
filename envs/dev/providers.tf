terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" { 
    bucket  = "multi-terra-dev-state-bucket-tf"
    region  = "us-east-1"
    key     = "dev/terraform.tfstate"
    encrypt = true
    profile = "vinicius.ferreira.dev"
  }

}

provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}