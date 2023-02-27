terraform {
  backend "s3" {
    bucket         = "axxes-cloud-workshop-sandbox-2023-tfstate"
    key            = "exxploration_nights/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "axxes-cloud-workshop-sandbox-2023-tfstate-lock"
    profile        = "workshop-sandbox-2023"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}