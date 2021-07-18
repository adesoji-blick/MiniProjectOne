variable "ssh_key" {
  default = "devOps-Project"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = "3"
}

variable "ami" {
  default = ["ami-0eac8bf7bc750f246", "ami-01a29514b932339ee", "ami-0332e42a1676a2ed2"]
}

variable "subnet_id" {
  default = ["subnet-043d2c27c0fd77ffa", "subnet-043d2c27c0fd77ffa", "subnet-0dc91894a5c94b6a7"]
}

# variable "sg_id" {
#   default = ["sg-06f7394d186ffd045", "sg-06f7394d186ffd045", "sg-06f7394d186ffd045"]
# }

variable "tag_name" {
  default = ["tool_sev_1", "tool_sev_2", "build_sev"]
}

variable "environment" {
  default = "development"
}

variable "role" {
  default = "devops_team"
}
