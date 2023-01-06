

# required vars

variable "aws_region" {
  description = "your aws region"
  type        = string
}

variable "credentials_file" {
  description = "the file that contains the details terraform will use to authenticate with aws"
  default     = "~/.aws/credentials"
}

variable "test_env_name" {
  description = "the name of the keypair your test env will create"
  type        = string
}

variable "profile" {
  description = "the aws credentials profile to use"
  type        = string
}

variable "creator" {
  description = "who is creating all this"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "what vpc you wish to use"
}

variable "subnet_id" {
  type        = string
  description = "subnet for the vpc you're using"
}

variable "cidr_blocks" {
  description = "your vpc's cidr block"
  default     = ["10.0.0.0/16"]
}

variable "access_ips" {
  type        = list(string)
  description = "the list of IPs that should have http and ssh access to the instance"
}

variable "user" {
  description = "the linux user that you will use when accessing the instance"
  default     = "ubuntu"
}

variable "instance_type" {
  description = "what kind of instance you want. recommended t2.micro to t2.medium"
  default     = "t2.micro"
}

variable "ami" {
  description = "what ami to provision"
  default     = "ami-0892d3c7ee96c0bf7"
}

variable "instance_home" {
  description = "the home for your instance"
  default     = "/home/ubuntu"
}

variable "instance_cnt" {
  description = "set to 1 to build an instance, set to 0 to destroy it. useful for retrying setup"
  default     = 1
}

variable "extra_security_group_ids" {
  type        = list(string)
  description = "ids for security groups that you may want to add to your instance"
  default     = []
}

variable "instance_global_vars" {
  type        = map(any)
  description = "map to define global variables in the instance you build"
  default     = {}
}

variable "setup_path" {
  type        = string
  description = "overwrite the path that contains your setup.sh and ./data directory"
  default     = ""
}