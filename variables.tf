variable "region" {
  default = "ca-central-1"
}

variable "profile" {
  default = "default"
}

variable "ssh_key" {
  default = "devOps-Project"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = "3"
}

variable "ami_filter" {
  default = ["packer-amazon-linux-ami1", "packer-amazon-linux-ami2", "packer-ubuntu-ami"]
}

variable "subnet_cidr_block" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "rt_cidr_block" {
  default = "0.0.0.0/24"
}

variable "availability_zone" {
  default = ["ca-central-1a", "ca-central-1b", "ca-central-1a"]
}

variable "tag_name" {
  default = ["tool_sev_1", "tool_sev_2", "build_sev"]
}

variable "environment" {
  default = "development"
}

variable "role" {
  default = "devops_team"
}
