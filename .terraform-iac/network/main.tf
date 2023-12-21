# recupère dynamiquement les zones de disponibilités
data "aws_availability_zones" "available" {}



module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.4.0"

    name = "${var.app}-VPC"

    cidr               = var.vpc_cidr
    azs                = data.aws_availability_zones.available.names
    private_subnets    = var.private_subnets
    public_subnets     = var.public_subnets
    create_igw         = true
    enable_nat_gateway = false
    map_public_ip_on_launch = true

    tags = {
      app         = "${var.app}"
      tf_module   = "${var.app}-vpc"
  }
}

module "alb" {
    source = "terraform-aws-modules/alb/aws"

    name = "${var.app}-ALB"

    load_balancer_type = "network"
    vpc_id             = module.vpc.vpc_id
    subnets            = module.vpc.public_subnets
    security_groups    = [ "${module.alb_sg.security_group_id}" ]

    tags = {
      app         = "${var.app}"
      tf_module   = "${var.app}-ALB"
  }
}

resource "aws_lb_listener" "app-alb-listener" {
    load_balancer_arn = module.alb.this_lb_arn
    port              = 443
    protocol          = "TCP"

    default_action {
        type             = "forward"
        target_group_arn =  aws_alb_target_group.app-alb-target-group.arn
    }
}

resource "aws_alb_target_group" "app-alb-target-group" {
    name     = "${var.app}-ALB-TG"
    port     = 443
    protocol = "TCP"
    vpc_id   = module.vpc.vpc_id

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        interval            = 30
        path                = "/"
        matcher             = "200"
    }
}

module "alb_sg" {
    source = "terraform-aws-modules/security-group/aws"
    version = "4.0.0"

    name        = "${var.app}-ALB-SG"
    description = "Security group for ALB"

    vpc_id = module.vpc.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["https-443-tcp"]

    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
    tags = {
      app         = "${var.app}"
      tf_module   = "${var.app}-ALB-SG"
  }
}
