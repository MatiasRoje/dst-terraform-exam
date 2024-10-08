terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }

  backend "s3" {
    bucket = "mr-terraform-exam-backend"
    key    = "terraform/terraform.tfstate"
    region = "eu-west-3"
  }

  required_version = "~> 1.3"
}

provider "aws" {
  region = "eu-west-3"
}