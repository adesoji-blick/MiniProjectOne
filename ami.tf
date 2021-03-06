# Use terraform to query latest generated AMI..

data "aws_ami" "packer-ami" {
  count = 3

  filter {
    name   = "tag:Name"
    values = [var.ami_filter[count.index]]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  most_recent = true
  owners      = ["self"]
}
