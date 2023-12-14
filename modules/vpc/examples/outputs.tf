
output "default-vpc" {
	value = module.default-vpc.vpc
}

output "default-vpc-subnets" {
	value = module.default-vpc.subnets
}

output "default-vpc-security-group" {
	value = module.default-vpc.security_group
}

