#Selecao da AMI

data "aws_ami" "latest_ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["591542846629"]
}

#Script para config no boot do Cluster

data "template_file" "ecs-cluster" {
  template = file("java-demo/ecs/ecs-cluster.tpl")

  vars = {
    ecs_cluster = aws_ecs_cluster.java.name
  }
}
