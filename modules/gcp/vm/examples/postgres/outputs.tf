
output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = module.my-postgres-1.instance_public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the instance"
  value       = module.my-postgres-1.instance_private_ip
}

output "ssh_private_key" {
  description = "SSH private key for connecting to the instance"
  value       = module.my-postgres-1.ssh_private_key
  sensitive   = true
}

output "ssh_connection_command" {
  description = "Command to SSH into the instance"
  value       = module.my-postgres-1.ssh_connection_command
  sensitive   = true
}
