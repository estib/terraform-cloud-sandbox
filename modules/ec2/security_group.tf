
resource "aws_security_group" "test-env" {
  name        = var.test_env_name
  description = "Manage in/egress access for ${var.test_env_name} instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    description = "allow ssh from listed IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      for ip in var.access_ips :
      ip
    ]
  }

  ingress {
    description = "allow https from listed IPs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      for ip in var.access_ips :
      ip
    ]
  }

  ingress {
    description = "allow 80 from listed IPs"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      for ip in var.access_ips :
      ip
    ]
  }

  ingress {
    description = "allow 3000 from listed IPs (for grafana)"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [
      for ip in var.access_ips :
      ip
    ]
  }

  ingress {
    description = "allow 8080 from listed IPs"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      for ip in var.access_ips :
      ip
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.test_env_name,
    Creator = var.creator
  }

}
