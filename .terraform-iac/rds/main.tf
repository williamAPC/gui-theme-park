data aws_availability_zones "available" {}

module "rds" {
    source  = "terraform-aws-modules/rds/aws"

    identifier = "tpr-db"

    availability_zone = data.aws_availability_zones.available.names

    engine              = var.engine
    engine_version      = var.engine_version
    family              = var.family
    instance_class      = var.instance_class
    allocated_storage   = var.allocated_storage
    multi_az            = false
    deletion_protection = true

    db_name  = var.db_name
    username = var.db_username
    password = var.db_password
    port     = 3306

    manage_master_user_password = false

    vpc_security_group_ids = [module.rds_sg.security_group_id]

    create_db_subnet_group = true
    db_subnet_group_name   = "themeparkride-db-subnet-group"
    subnet_ids             = var.private_subnets_ids

    create_db_parameter_group = false

    options  = []
}

module "rds_sg" {
    source  = "terraform-aws-modules/security-group/aws"

    name        = "rds_sg"
    description = "Security group for RDS"
    vpc_id      = module.network.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules       = ["mysql-tcp"]

    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules       = ["all-all"]
}
