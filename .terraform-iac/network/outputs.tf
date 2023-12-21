output "vpc_id" {
    description = "VPC ID"
    value       = module.vpc.vpc_id
}

output "internet_gateway_ip" {
    description = "Internet Gateway IP"
    value       = module.vpc.internet_gateway_ip
}

output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}
