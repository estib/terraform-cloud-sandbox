
resource "aws_security_group" "accept_from_self" {
  name        = format("accept_from_self - %s", var.name)
  description = format("Accept traffic from self - %s", var.name)
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow traffic from self"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, 
    {
      Name    = var.name,
      Creator = var.creator
    }
  )

}
