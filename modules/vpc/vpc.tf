
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = merge(var.tags, 
    {
      Name    = var.name,
      Creator = var.creator
    }
  )
}