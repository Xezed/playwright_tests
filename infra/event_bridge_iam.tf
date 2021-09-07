resource "aws_iam_policy" "policy_for_event_bridge" {
  name = "policy_for_event_bridge"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect: "Allow",
        Action: [
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:DescribeTasks"
        ],
        Resource: "*"
      },
      {
        Effect: "Allow",
        Action: [
          "events:PutTargets",
          "events:PutRule",
          "events:DescribeRule"
        ],
        Resource: "*"
      },
      {
        Effect: "Allow",
        Action: [
          "iam:PassRole",
        ],
        Resource: "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "event_bridge_attach" {
  role = aws_iam_role.role_for_event_bridge.name
  policy_arn = aws_iam_policy.policy_for_event_bridge.arn
}

resource "aws_iam_role" "role_for_event_bridge" {
  name = "role_for_event_bridge"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    Project = "playwright_tests"
  }
}
