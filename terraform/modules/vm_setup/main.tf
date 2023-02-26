terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "workshop-sandbox-2023"
}

resource "aws_instance" "test_instance" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t2.micro"

  tags = {
    Owner = "jdeboeck"
    Project = "exxploration_nights"
    Name = "aws_instance_jdeboeck"
  }
}
