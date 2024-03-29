#Configuracao do SG para liberar acesso as portas

resource "aws_security_group" "lb_sg" {
  description = "controls access to the application ELB"

  vpc_id = aws_vpc.java-tf.id
  name   = "java-ELB"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

#Configuracao do SG para liberar acesso as portas

resource "aws_security_group" "instance_sg" {
  description = "controls direct access to application instances"
  vpc_id      = aws_vpc.java-tf.id
  name        = "application-instances-sg"

  ingress {
    protocol    = "tcp"
    from_port   = 32768
    to_port     = 65535
    description = "Access from ALB"

    security_groups = [
      aws_security_group.lb_sg.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
