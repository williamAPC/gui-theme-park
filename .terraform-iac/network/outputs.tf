output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "cidr" {
  description = "List of IDs subnets"
  value       = module.vpc.cidr
}

output "azs" {
  description = "List of IDs of private subnets"
  value       = module.vpc.azs
}