terraform {
  backend "s3" {
    bucket = var.backend_bucket_name
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
