output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = var.instance_cnt > 0 ? google_compute_instance.default[0].network_interface[0].access_config[0].nat_ip : null
}

output "instance_private_ip" {
  description = "Private IP address of the instance"
  value       = var.instance_cnt > 0 ? google_compute_instance.default[0].network_interface[0].network_ip : null
}

output "ssh_private_key" {
  description = "SSH private key for connecting to the instance"
  value       = tls_private_key.test-env-key.private_key_pem
  sensitive   = true
}

output "ssh_connection_command" {
  description = "Command to SSH into the instance using the generated key file"
  value       = var.instance_cnt > 0 ? "ssh -i ${local_file.private_key.filename} ${var.user}@${google_compute_instance.default[0].network_interface[0].access_config[0].nat_ip}" : null
}

output "ssh_key_file_path" {
  description = "Path to the generated SSH private key file"
  value       = local_file.private_key.filename
}
