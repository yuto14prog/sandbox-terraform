module "ecr" {
  source          = "../modules/ecr"
  repository_name = "test-image"
}
