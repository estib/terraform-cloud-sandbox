
# required vars

variable "aws_region" {
  type        = string
  description = "your aws region"
}

variable "aws_availability_zones" {
  type        = list(string)
  description = "aws availability zones to add subnets to"
}

variable "credentials_file" {
  type        = string
  description = "the file that contains the details terraform will use to authenticate with aws"
  default     = "~/.aws/credentials"
}

variable "profile" {
  type        = string
  description = "the aws credentials profile to use"
}

variable "name" {
  type        = string
  description = "the name of your vpc"
}

variable "cidr_block" {
  type        = string
  description = "what cidr block to use for your vpc"
  default     = "172.16.0.0/16"
}

variable "creator" {
  type        = string
  description = "who is creating all this"
}

variable "tags" {
  type        = map(string)
  description = "tags you want applied to your vpc resources"
  default     = {}
}