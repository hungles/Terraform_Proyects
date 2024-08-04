##Proveedor##
provider "aws" {
  region = "us-east-1"
}

##recurso##

resource "aws_instance" "nginx-server" {
  ami = "ami-0ba9883b710b05ac6"
  instance_type = "t2.micro"
}