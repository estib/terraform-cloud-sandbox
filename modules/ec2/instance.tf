
locals {
  setup_path = length(var.setup_path) > 0 ? "${path.root}/${var.setup_path}" : path.root
}

resource "aws_instance" "test-env-instance" {
  count = var.instance_cnt

  ami           = var.ami
  instance_type = var.instance_type

  key_name = aws_key_pair.test-env-pair.key_name

  vpc_security_group_ids = concat([aws_security_group.test-env.id], var.extra_security_group_ids)

  subnet_id = var.subnet_id

  tags = {
    Name    = "${var.creator}-${var.test_env_name}"
    Creator = var.creator
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.user
    private_key = tls_private_key.test-env-key.private_key_pem
    timeout     = "5m"
  }

  provisioner "file" {
    source      = "${local.setup_path}/setup.env"
    destination = "${var.instance_home}/setup.env"
  }

  provisioner "file" {
    source      = "${local.setup_path}/setup.sh"
    destination = "${var.instance_home}/setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir ${var.instance_home}/data",
    ]
  }

  provisioner "remote-exec" {
    inline = concat(
      ["sudo touch /etc/profile.d/global_vars.sh"],
      [for k, v in var.instance_global_vars : "echo \"${k}=${v}\" | sudo tee -a /etc/profile.d/global_vars.sh"]
    )
  }

  provisioner "file" {
    source      = "${local.setup_path}/data"
    destination = "${var.instance_home}/"
  }

  provisioner "remote-exec" {
    script = "${local.setup_path}/setup.sh"
  }
}
