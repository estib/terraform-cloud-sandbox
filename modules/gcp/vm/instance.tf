
locals {
  setup_path   = length(var.setup_path) > 0 ? "${path.root}/${var.setup_path}" : path.root
  network_name = var.network_name != null ? var.network_name : "${var.test_env_name}-network"
}

resource "google_service_account" "default" {
  account_id   = "${var.creator}-${var.test_env_name}-sa"
  display_name = "${var.creator}'s Custom SA for ${var.test_env_name} VM Instance"
}

resource "google_compute_instance" "default" {
  count = var.instance_cnt

  name         = "${var.test_env_name}-vm"
  machine_type = var.instance_type
  zone         = var.gcp_zone

  tags = ["${var.test_env_name}-vm"]

  labels = {
    name    = "${var.creator}-${var.test_env_name}"
    creator = var.creator
  }

  metadata = {
    ssh-keys = "${var.user}:${tls_private_key.test-env-key.public_key_openssh}"
  }

  boot_disk {
    initialize_params {
      image = var.instance_image
      labels = {
        creator = var.creator
        test    = var.test_env_name
      }
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      # Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  connection {
    host        = self.network_interface[0].access_config[0].nat_ip
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
