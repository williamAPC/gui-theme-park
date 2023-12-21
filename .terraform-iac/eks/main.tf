module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"

    cluster_name    = "tmptpr"
    cluster_version = "1.28"

    vpc_id = var.vpc_id
}
