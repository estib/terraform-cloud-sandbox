
resource "aws_subnet" "this" {
  for_each = { for i, az in var.aws_availability_zones : i => az }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = format("172.16.1%s.0/24", each.key)
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = merge(var.tags, 
    {
      Name    = format("%s-%s", var.name, each.key),
      Creator = var.creator
    }
  )
}

resource "aws_route_table_association" "this" {
  for_each = { for i, az in var.aws_availability_zones : i => az }

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.this.id
}
