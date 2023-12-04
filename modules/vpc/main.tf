
provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = [var.credentials_file]
  profile                  = var.profile
}