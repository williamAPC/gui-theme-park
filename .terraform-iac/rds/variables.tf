variable "aws_region" {
  type        = string
  default     = "eu-west-3"
}

variable "app" {
  type        = string
  description = "App name"
  default     = "tpr"
}
/*
variable "private_subnets" {
  type = list(string)
}*/

/*
variable "public_subnets" {
  type = list(string)
}*/

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_password" {
  type = string
  default = "admin123"
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "engine" {
  type        = string
  description = "type of database engine"
  default     = "mariadb"
}

variable "engine_version" {
  type        = string
  description = "version of database engine"
  default     = "10.4"
}

variable "major_engine_version" {
  type        = string
  description = "major engine version"
  default     = "10.4"
}

variable "family" {
  type        = string
  description = "family of database engine"
  default     = "mariadb10.4"
}

variable "instance_class" {
  type        = string
  description = "instance class of database engine"
  default     = "db.t2.micro"
}

variable "allocated_storage" {
  type        = number
  description = "allocated storage of database engine"
  default     = 5
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnets"
  default     = ["10.0.0.0/18", "10.0.64.0/18"]
}

variable "private_subnets" {
  type        = list(string)
  description = "Privatesubnets"
 # default     = ["10.0.128.0/18", "10.0.192.0/18"]
}

variable "subnet_ids" {
  type        = list(string)
  description = "Privatesubnets"
  default     = ["10.0.128.0/18", "10.0.192.0/18"]
}

/*
variable "private_subnets" {
  type        = string
  description = "Private subnets1"
  default     = "10.0.128.0/18"
}

variable "private_subnets2" {
  type        = string
  description = "Private subnets2"
  default     = "10.0.192.0/18"
}*/