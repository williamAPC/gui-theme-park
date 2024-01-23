terraform {
  cloud {
    organization = "GuillaumeHenriOrg"
    workspaces {
       name = "my-demo-test"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = ${{ secret.AWS_ACCESS_KEY }}
  secret_key = ${{ secret.AWS_SECRET_ACCESS_KEY }}
}
