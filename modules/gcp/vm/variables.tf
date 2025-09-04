
# required vars

variable "gcp_project" {
  description = "your gcp project"
  type        = string
}

variable "gcp_region" {
  description = "your gcp region"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "your gcp zone"
  type        = string
  default     = "us-central1-c"
}

variable "test_env_name" {
  description = "the name of the keypair your test env will create"
  type        = string
}

variable "creator" {
  description = "who is creating all this"
  type        = string
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
  description = "what kind of instance you want. recommended e2-micro to e2-medium"
  default     = "e2-micro"
}

variable "instance_image" {
  description = "what kind of boot image you want for your instnace. defaults to an ubuntu 24.04"
  default     = "ubuntu-2404-noble-amd64-v20250828"
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

variable "extra_ingress_rules" {
  type        = map(any)
  description = "add custom ingress rules to your security group for accessing apps on custom ports"
  default     = {}
}

variable "network_name" {
  description = "name of your vpc network"
  type        = string
  default     = null # will be computed as "${test_env_name}-network" if not provided
}
