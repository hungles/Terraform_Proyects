##Proveedor##
provider "aws" {
  region = "us-east-1"
}

##Recurso##

resource "aws_instance" "nginx-server" {
  ami = "ami-0ba9883b710b05ac6"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF

  key_name = aws_key_pair.nginx-server-ssh.key_name
  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id]

  tags = {
    Name = "nginx-server"
    Enviroment = "test"
    Owner = "scarmona04@hotmail.com"
    Team = "Devops"
    Proyect = "hunglesti"
  }

}

###Llaves SSH###
resource "aws_key_pair" "nginx-server-ssh" {
  key_name = "nginx-server-ssh"
  public_key = file("nginx-server.key.pub")

  tags = {
    Name = "nginx-server-ssh"
    Enviroment = "test"
    Owner = "scarmona04@hotmail.com"
    Team = "Devops"
    Proyect = "hunglesti"
  }
}


###Security Groups###
resource "aws_security_group" "nginx-server-sg" {
  
  name = "nginx-server-sg"
  description = "Security Group para mis servidores nginx"

  ingress {
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-server-sg"
    Enviroment = "test"
    Owner = "scarmona04@hotmail.com"
    Team = "Devops"
    Proyect = "hunglesti"
  }


}

output "server_public_dns" {
    description = "Obtener la direccion DNS de mis instancias"
    value = aws_instance.nginx-server.public_dns
  }

output "server_public_ip" {
  description = "Obtener la direccip ip publica de mis instancias"
  value = aws_instance.nginx-server.public_ip
}