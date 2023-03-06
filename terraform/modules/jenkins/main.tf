resource "aws_instance" "jenkins" {
  ami                         = "ami-06e0ce9d3339cb039"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ssh.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins_allow_ssh.id, aws_security_group.jenkins_allow_http.id]
  subnet_id                   = aws_subnet.main.id

  tags = merge(var.default_tags,
    { Name = "jenkins_instance" })
}

resource "aws_security_group" "jenkins_allow_ssh" {
  name        = "jenkins_allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.default_tags,
    { Name = "jenkins_allow_ssh" })
}

resource "aws_security_group" "jenkins_allow_http" {
  name        = "jenkins_allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.default_tags,
    { Name = "jenkins_allow_http" })
}

/*resource "aws_eip" "jenkins_public_ip" {
  instance = aws_instance.jenkins.id
  vpc      = true
  tags = var.default_tags
}*/