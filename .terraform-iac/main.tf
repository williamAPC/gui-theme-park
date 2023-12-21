module "eks" {
    source = "./eks"
    vpc_id = module.network.vpc_id
}

module "network" {
    source          = "./network"
    vpc_cidr        = var.vpc_cidr
    aws_region      = var.aws_region
    private_subnets = var.private_subnets
    public_subnets  = var.public_subnets
}

module "rds" {
    source      = "./rds"
    aws_region  = var.aws_region
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password
}
