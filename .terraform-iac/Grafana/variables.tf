variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "public_subnet1_id" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "linux2_ami" {
  type = string
}

variable "ssh_port" {
  type = string
}

#variable "http_port" {
#  type = number
#}

#variable "https_port" {
#  type = number
#}

variable "grafana_port" {
  type = string
}

variable "micro_instance" {
  type = string
}

variable "key_name" {
  type = string
}