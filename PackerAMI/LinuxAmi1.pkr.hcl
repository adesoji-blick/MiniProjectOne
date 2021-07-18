packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = "linux-ami1"
  instance_type = "t2.micro"
  region        = "ca-central-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"

  tags = {
    Name = "packer-amazon-linux-ami1"
  }
}

build {
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "shell" {

    inline = [
      "echo installing GIT",
      "sudo yum install git -y",
      "echo installing Java OpenJDK 11",
      "curl https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz -O",
      "tar xvf openjdk-11*_bin.tar.gz",
      "echo Installing Ansible",
      "sudo amazon-linux-extras install ansible2 -y",
    ]
  }
}