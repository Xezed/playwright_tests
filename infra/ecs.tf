resource "aws_ecr_repository" "playwright_tests" {
  name = "playwright_tests"
}

resource "aws_ecs_cluster" "playwright_tests" {
  name = "playwright_tests"

  tags = {
    Project = "playwright_tests"
  }
}

resource "aws_cloudwatch_log_group" "playwright_tests" {
  name = "/ecs/playwright_tests"
}

resource "aws_ecs_task_definition" "playwright_tests" {
  family = "playwright_tests"
  execution_role_arn = module.iam.role_for_ecs_task_execution_arn

  container_definitions = jsonencode([
    {
      logConfiguration: {
        logDriver: "awslogs",
        options: {
          awslogs-group: aws_cloudwatch_log_group.playwright_tests.name,
          awslogs-region: 'us-west-2',
          awslogs-stream-prefix: "ecs"
        }
      },
      image: "${aws_ecr_repository.playwright_tests.repository_url}:latest",
      name: "playwright_tests",
    }
  ])

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]

  cpu = "2048"
  memory = "4096"

  tags = {
    Project = "playwright_tests"
  }
}
