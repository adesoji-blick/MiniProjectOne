source "amazon-ebs" "amazon-linux2" {
  ami_name      = "linux-ami2"
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
    Name = "packer-amazon-linux-ami2"
  }
}

build {
  sources = [
    "source.amazon-ebs.amazon-linux2"
  ]

  provisioner "shell" {

    inline = [
      "echo installing GIT",
      "sudo yum install git -y",
      "echo installing Java OpenJDK 11",
      "curl https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz -O",
      "tar xvf openjdk-11*_bin.tar.gz",
      "echo Installing Terraform",
      "curl https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.2_linux_amd64.zip -O",
      "unzip terraform_1.0.2_linux_amd64.zip",
      "sudo cp terraform /usr/local/bin/",
      "echo Installing Packer",
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum -y install packer",
    ]
  }
}