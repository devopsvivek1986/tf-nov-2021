terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
    region = "us-west-2"
    access_key = "AKIAZBO66PLYYPKDGAZD"
    secret_key = "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"
}

resource "aws_security_group" "vivek_allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  
  ingress {
    description      = "Allow HTTP to Instance"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vivek_allow_http"
  }
}

resource "aws_instance" "vivek_app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vivek_allow_http.id]

  tags = {
    Name = "vivek_app_server - Nov 22 2021"
  }
}

