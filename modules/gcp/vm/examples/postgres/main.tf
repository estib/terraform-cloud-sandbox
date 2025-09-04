module "my-postgres-1" {
  source        = "estib/sandbox/cloud//modules/gcp/vm"
  version       = "0.1.3"
  gcp_project   = "my-project"
  test_env_name = "postgres-1"
  creator       = "terra.branford"
  gcp_region    = "us-central1"
  gcp_zone      = "us-central1-c"
  access_ips    = ["MY.IP.V.4/32"]
  network_name  = "postgres-1-vpc"

  # if you wanted to access postgres directly from your whitelisted IPs...
  extra_ingress_rules = {
    "postgresql" = {
      "port"     = "5432"
      "protocol" = "tcp" # optional, defaults to "tcp"
    }
  }
}
