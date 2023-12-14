
module "default-vpc" {
  source                 = "estib/sandbox/cloud//modules/vpc"
  version                = "0.1.2"
  profile                = "my-profile"
  name                   = "default"
  aws_region             = "figaro-south-1"
  aws_availability_zones = ["figaro-south-1a", "figaro-south-1b", "figaro-south-1c"]
  creator                = "terra.branford"

  tags = {
  	Team = "Moogle"
  }
}