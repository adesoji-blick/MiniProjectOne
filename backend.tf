terraform {
  backend "s3" {
    bucket = "ijoseda-devops"
    key    = "Devops2021/DevopsProject/project2-statefile"
    region = "ca-central-1"
  }
}