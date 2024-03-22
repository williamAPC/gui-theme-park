
provider "aws" {
  region = "eu-west-3"
}



terraform {
  backend "s3" {
    bucket =  "guitests3bucket"
    key = "tpriacstate/terraform.tfstate"
#       region can't be set with variables.tf here, should be set with environment variable AWS_REGION
    region = "eu-west-3"
    # dynamodb_table = "tpr-tfstate-locking"
    # encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


