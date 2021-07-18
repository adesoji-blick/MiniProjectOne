terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ca-central-1"
}

resource "aws_instance" "mini_project" {
  ami                    = element(var.ami, count.index)
  instance_type          = var.instance_type
  count                  = var.instance_count
  key_name               = var.ssh_key
  subnet_id              = element(var.subnet_id, count.index)
  vpc_security_group_ids = ["sg-06f7394d186ffd045", "sg-06f7394d186ffd045", "sg-06f7394d186ffd045"]
  # subnet_id     = "${aws_subnet.subnet_1.id}, ${aws_subnet.subnet_1.id}, ${aws_subnet.subnet_2.id}"
  # vpc_security_group_ids     = element(var.sg_id, count.index)
  # vpc_security_group_ids = ["aws_security_group.tool_server_sg.id", "aws_security_group.tool_server_sg.id", "aws_security_group.build_server_sg.id"]

  tags = {
    # Name        = "Tool-Server${count.index + 1}"
    Name        = element(var.tag_name, count.index)
    environment = "${var.environment}"
    role        = "${var.role}"
  }
}