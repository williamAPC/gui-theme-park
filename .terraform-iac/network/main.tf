# recupère dynamiquement les zones de disponibilités
#data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "${var.app}-VPC"

  cidr                    = "10.0.0.0/16"
  azs                     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  private_subnets         = ["10.0.128.0/18", "10.0.192.0/18"]
  public_subnets          = ["10.0.0.0/18", "10.0.64.0/18"]
  create_igw              = true
  enable_nat_gateway      = false
  map_public_ip_on_launch = true
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  tags = {
    app       = "${var.app}"
    tf_module = "${var.app}-vpc"
  }
}
