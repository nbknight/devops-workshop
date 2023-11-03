terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.24.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "terraform-personal"
}

resource "aws_instance" "demo-server" {
    ami = "ami-01bc990364452ab3e"
    instance_type = "t2.micro"
    key_name = "dpp"
    security_groups = [ "demo-sg"]
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-sg"
  description = "Allow SSH access to ec2"

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-port"
  }
}