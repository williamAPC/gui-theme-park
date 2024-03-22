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
  region = "eu-west-3"
  share_credentials_files = ["credentials"]
  profile = "testusertest"
  }