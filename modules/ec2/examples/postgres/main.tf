module "my-postgres-1" {
  source                   = "estib/sandbox/cloud//modules/ec2"
  version                  = "0.1.2"
  test_env_name            = "my-postgres-1"
  creator                  = "terra.branford"
  profile                  = "my-profile"
  aws_region               = "figaro-south-1"
  instance_cnt             = var.instance_cnt
  access_ips               = ["MY.IP.V.4/32"]         
  vpc_id                   = "my-vpcid"    
  subnet_id                = "my-subnetid" 
  # vpc_id                   = data.terraform_remote_state.vpc.outputs.default-vpc.id    # "CHANGE_ME"
  # subnet_id                = data.terraform_remote_state.vpc.outputs.default-vpc-subnets.0.id # "CHANGE_ME"
  extra_security_group_ids = ["my-sgid"]
}

provider "aws" {
  region  = "figaro-south-1"
  profile = "my-profile"
}

/*
# Optionally refer to another module for its VPC
data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "/path/to/modules/vpc/terraform.tfstate"
  }
}
*/