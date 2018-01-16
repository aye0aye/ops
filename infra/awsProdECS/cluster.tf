# ECS clusters
resource "aws_ecs_cluster" "prod-aws" {
  name = "${ECS_CLUSTER_NAME}
}
