#Criacao do ALB

resource "aws_alb" "java_us_alb" {
  name            = "java-us-alb"
  subnets         = [aws_subnet.java-public-1.id, aws_subnet.java-public-2.id, aws_subnet.java-public-3.id]
  security_groups = [aws_security_group.lb_sg.id]
  enable_http2    = "true"
  idle_timeout    = 600
}

#Printar na tela a url do ALB

output "alb_output" {
  value = aws_alb.java_us_alb.dns_name
}

#Configuracao do ALB para destino

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.java_us_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.node.id
    type             = "forward"
  }
}

#Criacao do destino do ALB e path de verificacao

resource "aws_alb_target_group" "node" {
  name       = "node"
  port       = 8080
  protocol   = "HTTP"
  vpc_id     = aws_vpc.java-tf.id
  depends_on = [aws_alb.java_us_alb]

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
  }

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}
