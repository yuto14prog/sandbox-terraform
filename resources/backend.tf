terraform {
  backend "s3" {
    bucket = "sandbox-terraform-infra"
    key    = "sandbox-terraform/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
