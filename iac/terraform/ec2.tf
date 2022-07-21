resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allows SSH connections"

  ingress {
    description = "SSH from 0.0.0.0/0"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Outbound connections"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "webapp_sg" {
  name = "webapp_sg"
  description = "Allows HTTP connections"

  ingress {
    description = "HTTP from 0.0.0.0/0"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "HTTPS from 0.0.0.0/0"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "TCP:3000 from 0.0.0.0/0"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "TCP:9292 from 0.0.0.0/0"
    from_port = 9292
    to_port = 9292
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Outbound connections"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "webapp_sg"
  }
}

resource "aws_instance" "t3_small" {
  ami = "ami-0c4f7023847b90238" # Ubuntu 20.04 LTS
  instance_type = "t3.small"
  associate_public_ip_address = true
  key_name = "maracuja-key"

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.webapp_sg.id
  ]

  tags = {
    Name = "maracuja-t3-small"
  }
}

output "maracuja_public_ip" {
  value = aws_instance.t3_small.public_ip
}
