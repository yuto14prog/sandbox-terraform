module "fargate" {
  source = "../modules/ecs"

  cluster_name       = "test-cluster"
  execution_role_arn = module.ecs_execution_role.role_arn
  task_role_arn      = module.ecs_task_role.role_arn
  container_definition = jsonencode([
    {
      name      = "app"
      image     = "${data.aws_caller_identity.current.account_id}.dkr-ecr.${data.aws_region.current.id}.on.aws/${module.ecr.repository_name}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  vpc_id     = module.ipv6.vpc_id
  subnet_ids = module.ipv6.private_subnet_ids
}
