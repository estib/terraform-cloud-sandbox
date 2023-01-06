resource "tls_private_key" "test-env-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "null_resource" "keypair-files-manager" {

  triggers = {
    test_env_name = var.test_env_name
    creator       = var.creator
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      echo '${tls_private_key.test-env-key.private_key_pem}' > ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pem
      echo '${tls_private_key.test-env-key.public_key_openssh}' > ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pub
      tput reset
      echo 'created private key at ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pem and public key openssh at ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pub'
      chmod 400 ~/.ssh/${self.triggers.creator}-${var.test_env_name}-key.pem
      EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      rm ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pem
      rm ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pub
      echo 'deleted private key at ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pem and public key openssh at ~/.ssh/${self.triggers.creator}-${self.triggers.test_env_name}-key.pub'
      EOT
  }
}

resource "aws_key_pair" "test-env-pair" {
  key_name   = "${var.creator}-${var.test_env_name}-key"
  public_key = tls_private_key.test-env-key.public_key_openssh
}