terraform {
  cloud {
    organization = "summercloud"

    workspaces {
      name = "project"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "1.6.2"
}
provider "aws" {
  region = "us-east-1"
}
 