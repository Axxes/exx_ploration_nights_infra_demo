resource "aws_instance" "jenkins" {
  ami                = "ami-06e0ce9d3339cb039"
  instance_type      = "t2.micro"
  key_name           = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_allow_ssh.id]
  subnet_id          = aws_subnet.main.id
  tags               = merge(var.default_tags,
    { Name = "jenkins_instance" })
}

resource "aws_security_group" "jenkins_allow_ssh" {
  name        = "jenkins_allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    { Name = "allow_tls" })
}

resource "aws_eip" "ip-test-env" {
  instance = aws_instance.jenkins.id
  vpc      = true
}