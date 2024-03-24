
resource "aws_db_subnet_group" "mariadb-subnets" {
    name        = "mariadb-subnets"
    description = "Amazon RDS subnet group"
    subnet_ids  = [var.public_subnets]
}

#RDS Parameters
resource "aws_db_parameter_group" "tpr-mariadb-parameters" {
    name        = "tpr-mariadb-parameters"
    family      = "mariadb10.4"
    description = "MariaDB parameter group"

    parameter {
      name  = "max_allowed_packet"
      value = "16777216"
  }
}

resource "aws_db_instance"  "tpr-mariadb" {
  identifier = "${var.app}-db"

  engine               = var.engine
  engine_version       = var.engine_version
  #major_engine_version = var.major_engine_version
  #family               = var.family
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  multi_az             = "false"
  #en production, activer la protection contre la suppression
  deletion_protection  = false
  #en production, activer la sauvegarde par snapshot avant la destruction de la BD
  skip_final_snapshot = true
  
  storage_encrypted    = false

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 3306

  manage_master_user_password = false

  vpc_security_group_ids = [module.rds_sg.security_group.id]

  #create_db_subnet_group = true
  db_subnet_group_name   = aws_db_subnet_group.mariadb-subnets.name
  parameter_group_name    = aws_db_parameter_group.tpr-mariadb-parameters.name
  # desactivation du name prefix qui ne fonctionne pas
 # db_subnet_group_use_name_prefix = false
 # subnet_ids                      = var.public_subnets

  #create_db_parameter_group = false

  tags = {
    app       = "${var.app}"
    tf_module = "${var.app}-RDS"
  }
}

resource "aws_security_group" "rds_sg" {
  
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow-levelup-ssh.id]
  }
  
  tags = {
    Name = "allow-mariadb"
  }
}
