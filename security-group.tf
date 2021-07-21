# Security Group Creation #

resource "aws_security_group" "server_sg" {
  count  = var.instance_count
  name   = var.sg_name[count.index]
  vpc_id = aws_vpc.training_vpc.id
  # description             = "Allow SSH and HTTP inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.ingress_protocol
    cidr_blocks = [var.sg_cidr_block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = var.ingress_protocol
    cidr_blocks = [var.sg_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = var.egress_protocol
    cidr_blocks = [var.sg_cidr_block]
  }

  tags = {
    Name = "allow_ssh_and_http"
  }
}


# resource "aws_security_group" "build_server_sg" {
#   name        = "build_server_security_group"
#   description = "Allow SSH and 8080 inbound traffic"
#   vpc_id      = aws_vpc.training_vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_ssh_and_8080"
#   }
# }