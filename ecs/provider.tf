#Configuracao de plugin do terraform, versão e região da AWS

provider "aws" {
  profile = "default"
  version = ">= 2.1"
  region  = var.aws_region
}
