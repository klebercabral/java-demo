resource "aws_ecs_service" "node" {
  name            = "gradle-sample-app"
  cluster         = aws_ecs_cluster.java.id
  task_definition = aws_ecs_task_definition.node.arn
  desired_count   = 4
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_role_policy_attachment.ecs-service-attach]

  load_balancer {
    target_group_arn = aws_alb_target_group.node.id
    container_name   = "gradle-sample-app"
    container_port   = "8080"
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_ecs_task_definition" "node" {
  family = "node"

  container_definitions = <<EOF
[
  {
    "portMappings": [
      {
        "hostPort": 0,
        "protocol": "tcp",
        "containerPort": 8080
      }
    ],
    "cpu": 256,
    "memory": 300,
    "image": "klebercabral/gradle-sample-app:0.1.0",
    "essential": true,
    "name": "gradle-sample-app",
    "logConfiguration": {
    "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs-java/node",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
EOF

}

resource "aws_cloudwatch_log_group" "node" {
  name = "/ecs-java/node"
}
