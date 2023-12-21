output "vpc_id" {
    description = "VPC ID"
    value       = module.vpc.vpc_id
}

output "internet_gateway_ip" {
    description = "Internet Gateway IP"
    value       = module.vpc.internet_gateway_ip
}
