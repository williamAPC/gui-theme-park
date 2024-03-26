terraform {
  backend "s3" {
    bucket =  "guitests3bucket"
    key = "grafanastate/terraform.tfstate"
    #  region can't be set with variables.tf here, should be set with environment variable AWS_REGION
    region = "eu-west-3"
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


 provider "aws" {
  region = var.region
  }