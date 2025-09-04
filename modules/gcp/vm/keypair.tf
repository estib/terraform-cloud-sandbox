resource "tls_private_key" "test-env-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a temporary file for the private key
resource "local_file" "private_key" {
  content         = tls_private_key.test-env-key.private_key_pem
  filename        = "${path.module}/temp_ssh_key"
  file_permission = "0600"
}
