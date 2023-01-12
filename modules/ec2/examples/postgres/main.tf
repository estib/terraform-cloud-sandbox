module "my-postgres-1" {
  source                   = "estib/sandbox/cloud//modules/ec2"
  version                  = "0.1.0"
  test_env_name            = "my-postgres-1"
  creator                  = "terra.branford"
  profile                  = "my-profile"
  aws_region               = "figaro-south-1"
  instance_cnt             = var.instance_cnt
  access_ips               = ["MY.IP.V.4/32"]         
  vpc_id                   = "my-vpcid"    
  subnet_id                = "my-subnetid" 
  extra_security_group_ids = ["my-sgid"]
}

provider "aws" {
  region  = "figaro-south-1"
  profile = "my-profile"
}
