resource "aws_instance" "web" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t2.micro"
  key_name           = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.web_allow_ssh.id]
  subnet_id          = var.public_subnet_id
  tags               = merge(var.default_tags,
    { Name = "web_instance" })
}

resource "aws_security_group" "web_allow_ssh" {
  name        = "web_allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(var.default_tags,
    { Name = "web_allow_ssh" })
}

resource "aws_eip" "web_public_ip" {
  instance = aws_instance.web.id
  vpc      = true
}
