# recupère dynamiquement les zones de disponibilités
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "${var.app}-VPC"

  cidr                    = var.vpc_cidr
  azs                     = data.aws_availability_zones.available.names
  private_subnets1        = var.private_subnets1
  private_subnets2        = var.private_subnets2
  public_subnets          = var.public_subnets
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
