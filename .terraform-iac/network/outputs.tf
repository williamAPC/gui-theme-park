output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_nets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets1" {
  description = "private subnets1"
  value       = module.vpc.private_subnets1
}
output "private_subnets2" {
  description = "private subnets2"
  value       = module.vpc.private_subnets2
}

/*
output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets.id
}

output "public_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.public_subnets.id
}
*/