variable "aws_region" {
    type        = string
}

variable "db_name" {
    type        = string
}

variable "db_username" {
    type        = string
}

variable "db_password" {
    type        = string
    sensitive   = true
}

variable "private_subnets_ids" {
    type        = list(string)
}
