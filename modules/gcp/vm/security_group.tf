resource "google_compute_firewall" "ssh" {
  name    = "${var.test_env_name}-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.access_ips
  target_tags   = ["${var.test_env_name}-vm"]
}

resource "google_compute_firewall" "http" {
  name    = "${var.test_env_name}-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.access_ips
  target_tags   = ["${var.test_env_name}-vm"]
}

# Dynamic firewall rules for extra ingress
resource "google_compute_firewall" "extra_ingress" {
  for_each = var.extra_ingress_rules

  name    = "${var.test_env_name}-${each.key}"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = lookup(each.value, "protocol", "tcp")
    ports    = [each.value.port]
  }

  source_ranges = var.access_ips
  target_tags   = ["${var.test_env_name}-vm"]
}
