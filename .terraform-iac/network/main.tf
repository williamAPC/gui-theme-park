module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.4.0"

    name = "tmptpr-VPC"

    cidr               = var.vpc_cidr
    azs                = [var.aws_region + "a", var.aws_region + "b"]
    private_subnets    = var.private_subnets
    public_subnets     = var.public_subnets
    create_igw         = true
    enable_nat_gateway = false
}

module "alb" {
    source = "terraform-aws-modules/alb/aws"
    version = "5.0.0"

    name = "tmptpr-ALB"

    load_balancer_type = "network"
    vpc_id             = module.vpc.vpc_id
    subnets            = module.vpc.public_subnets
    security_groups    = module.alb_sg
}

resource "aws_lb_listener" "app-alb-listener" {
    load_balancer_arn = module.alb.alb_arn
    port              = 443
    protocol          = "HTTPS"

    default_action {
        type             = "forward"
        target_group_arn = module.app-alb-target-group.target_group_arn
    }
}

resource "aws_alb_target_group" "app-alb-target-group" {
    name     = "tmptpr-ALB-TG"
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

    name        = "tmptpr-ALB-SG"
    description = "Security group for ALB"

    vpc_id = module.vpc.vpc_id

    ingress_cidr_blocks = var.public_subnets
    ingress_rules = ["https-443-tcp"]

    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
}
