resource "aws_cloudwatch_event_rule" "trigger_playwright_tests_cron_event" {
  name                = "trigger_playwright_tests_cron_event"
  schedule_expression = "rate(5 minutes)"

  tags = {
    Project = "playwright_tests"
  }
}

resource "aws_cloudwatch_event_target" "state_machine_target" {
  rule     = aws_cloudwatch_event_rule.trigger_playwright_tests_cron_event.name
  arn      = aws_ecs_cluster.playwright_tests.arn
  role_arn = aws_iam_role.role_for_event_bridge.arn

  ecs_target {
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.playwright_tests.arn
    launch_type         = "FARGATE"

    network_configuration = {
      Subnets        = [
        aws_default_subnet.default_az1.id,
        aws_default_subnet.default_az2.id
      ],
      AssignPublicIp = "ENABLED",
    }
  }
}
