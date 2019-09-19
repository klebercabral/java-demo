#Utilizar regiao us-east-1

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

#Utilizar instancia t2.micro

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}
