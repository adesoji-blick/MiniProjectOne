terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

resource "aws_instance" "mini_project" {
  ami                    = data.aws_ami.packer-ami[count.index].id
  instance_type          = var.instance_type
  count                  = var.instance_count
  key_name               = var.ssh_key
  subnet_id              = aws_subnet.training_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.server_sg.id]


  tags = {
    Name        = element(var.tag_name, count.index)
    environment = "${var.environment}"
    role        = "${var.role}"
  }
}