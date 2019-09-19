#Criacao de role para criar instancias

resource "aws_iam_role" "ecs-ec2-role" {
  name = "ecs-ec2-role-test"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

#Definicao de profile da role para criar instancias

resource "aws_iam_instance_profile" "ecs-ec2-role" {
  name = "ecs-ec2-role-test"
  role = aws_iam_role.ecs-ec2-role.name
}

#Atribuir policy na role de criar instancias

resource "aws_iam_role_policy" "ecs-ec2-role-policy" {
  name = "ecs-ec2-role-policy-test"
  role = aws_iam_role.ecs-ec2-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "ecs:CreateCluster",
              "ecs:DeregisterContainerInstance",
              "ecs:DiscoverPollEndpoint",
              "ecs:Poll",
              "ecs:RegisterContainerInstance",
              "ecs:StartTelemetrySession",
              "ecs:Submit*",
              "ecs:StartTask",
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF

}

#Criacao de role para ECS

resource "aws_iam_role" "ecs-service-role" {
name = "ecs-service-role-test"

assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

#Atribuir policy na role do ECS

resource "aws_iam_role_policy_attachment" "ecs-service-attach" {
role = aws_iam_role.ecs-service-role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
