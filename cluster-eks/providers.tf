terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
  }

  backend "s3" {
    bucket = "devopsautomations"
    key    = "states/tutorial.tfstate"
    region = "us-east-1"
  }
}


# Configure the AWS Provider
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
}
