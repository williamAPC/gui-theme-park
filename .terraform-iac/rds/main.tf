module "rds" {
    source  = "terraform-aws-modules/rds/aws"

    identifier = "rds-identifier"

    engine              = "mariadb"
    engine_version      = "10.4"
    family              = "mariadb10.4"
    major_engine_version = "10.4" 
    instance_class      = "db.t2.micro"
    allocated_storage   = 5
    multi_az            = false
    deletion_protection = true
    storage_encrypted = false

    db_name  = var.db_name
    username = var.db_username
    password = var.db_password
    port     = 3306
    manage_master_user_password = false

    vpc_security_group_ids = [module.rds_sg.security_group_id]

    create_db_subnet_group = true
    db_subnet_group_name   = "db_subnet_group"
    # desactivation du name prefix qui ne fonctionne pas
    db_subnet_group_use_name_prefix = false
    subnet_ids = var.private_nets

    options  = []
    create_db_parameter_group = false

    tags = {
      app         = "${var.app}"
      tf_module   = "${var.app}-RDS"
    }
}

module "rds_sg" {
    source  = "terraform-aws-modules/security-group/aws"

    name        = "rds_sg"
    description = "Security group for RDS"
    vpc_id      = var.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules       = ["mysql-tcp"]

    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules       = ["all-all"]
}
