terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.region
  shared_credentials_files = ["./credentials"]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    description      = "Allow ssh"
    from_port        = 22 
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "allow_outgoing_traffic" {
  name        = "allow_all_out"
  description = "Allow all out going traffic"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "polka" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_outgoing_traffic.id}"]
  key_name = var.key_name
  count = var.instance_number
  tags = {
    Name = "polka${count.index}"
  }
}

output "instance_public_dns" {
  value = aws_instance.polka[*].public_dns
}