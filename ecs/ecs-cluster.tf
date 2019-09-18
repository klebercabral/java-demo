resource "aws_ecs_cluster" "java" {
  name = "java"
}

resource "aws_autoscaling_group" "java-cluster" {
  name                      = "java-cluster"
  vpc_zone_identifier       = [aws_subnet.java-public-1.id, aws_subnet.java-public-2.id, aws_subnet.java-public-3.id]
  min_size                  = "2"
  max_size                  = "10"
  desired_capacity          = "2"
  launch_configuration      = aws_launch_configuration.java-cluster-lc.name
  health_check_grace_period = 120
  default_cooldown          = 30
  termination_policies      = ["OldestInstance"]

  tag {
    key                 = "Name"
    value               = "ECS-java"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "java-cluster" {
  name                      = "java-ecs-auto-scaling"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = "90"
  adjustment_type           = "ChangeInCapacity"
  autoscaling_group_name    = aws_autoscaling_group.java-cluster.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40
  }
}

resource "aws_launch_configuration" "java-cluster-lc" {
  name_prefix     = "java-cluster-lc"
  security_groups = [aws_security_group.instance_sg.id]

  image_id                    = data.aws_ami.latest_ecs.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ecs-ec2-role.id
  user_data                   = data.template_file.ecs-cluster.rendered
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}
