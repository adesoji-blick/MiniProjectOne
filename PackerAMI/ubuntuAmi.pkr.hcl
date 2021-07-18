source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-ami2"
  instance_type = "t2.micro"
  region        = "ca-central-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    Name = "packer-ubuntu-ami"
  }
}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {

    inline = [
      "echo Installing Java openjdk",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install openjdk-8-jdk -y",
      "echo Installing jenkins",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt-get update",
      "sudo apt-get install jenkins -y",
      "sudo service jenkins start",
      "sudo service jenkins status",
    ]
  }
}
