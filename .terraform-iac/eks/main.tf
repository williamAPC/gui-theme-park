/*data "aws_eks_cluster_auth" "default" {
  name = "tpr"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.app}"
  cluster_version = "1.28"

  cluster_endpoint_public_access  = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.public_nets
  control_plane_subnet_ids = var.public_nets

  eks_managed_node_group_defaults = {
    ami_type = "${var.ami_type}"
    instance_types = ["${var.instance_types}"]
  }

  eks_managed_node_groups = {
    node-group1 = {
      name = "${var.app}-node-group"

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  cluster_addons = {
    amazon-cloudwatch-observability = {
      most_recent = true
    }
  }
  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::${var.account_id}:user/${var.user1}"
      username = "${var.user1}"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${var.account_id}:user/${var.user2}"
      username = "${var.user2}"
      groups   = ["system:masters"]
    },
        {
      userarn  = "arn:aws:iam::${var.account_id}:user/${var.user3}"
      username = "${var.user3}"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${var.account_id}:user/${var.user4}"
      username = "${var.user4}"
      groups   = ["system:masters"]
    },
  ]

  tags = {
    app         = "${var.app}"
    tf_module   = "${var.app}-eks"
  }
}

/*
resource "helm_release" "traefik_ingress" {
  name       = "traefik-ingress-controller"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
*/

