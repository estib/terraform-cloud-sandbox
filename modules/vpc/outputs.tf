output "vpc" {
  value = aws_vpc.this
}

output "subnets" {
  value = aws_subnet.this
}

output "security_group" {
  value = aws_security_group.accept_from_self
}