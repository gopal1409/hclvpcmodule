terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
backend "s3" {
  bucket = "terraform-state-gopal"
  key = "dev/terraform.tfstate"
  region = "ap-northeast-2"
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  profile = "default"
}