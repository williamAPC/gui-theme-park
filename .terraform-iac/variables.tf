variable "aws_region" {
    type        = string
    description = "Region AWS"
    default     = "eu-west-3"
}

variable "namespace" {
    type        = list(string)
    description = "Namespace applicatif et infra"
    default     = ["prod", "dev"]
}

variable "db_name" {
    type = string
    description = "DB name"
    default = "themparkride"
}

variable "db_username" {
    type = string
    description = "DB username"
    default = "admin"
}

variable "db_password" {
    type = string
    description = "DB password"
    sensitive = true
}

variable "vpc_cidr" {
    type        = string
    description = "VPC CIDR"
    default     = "192.168.0.0/16"
}

variable "private_subnets" {
    type = list(string)
    description = "Private subnets"
    default = ["192.168.128.0/18", "192.168.192.0/18"]
}

variable "public_subnets" {
    type = list(string)
    description = "Public subnets"
    default = ["192.168.0.0/18", "192.16864.0/18"]
}
