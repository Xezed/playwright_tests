terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    region  = "us-west-2"
    encrypt = true
    bucket  = "terraform-state-playwright"
    key     = "playwright.tfstate"
  }
}

provider "aws" {
  region  = "us-west-2"
}
