provider "aws" {
  region = "eu-central-1"   # change if you configured different region
}

resource "aws_security_group" "app_sg" {
  name        = "self-healing-sg"
  description = "Allow SSH and App Port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_instance" "app_server" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  security_groups = [aws_security_group.app_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker pull tantawy173/self-healing-app:latest
              docker run -d -p 5000:5000 tantawy173/self-healing-app:latest
              EOF

  tags = {
    Name = "self-healing-app-instance"
  }
}