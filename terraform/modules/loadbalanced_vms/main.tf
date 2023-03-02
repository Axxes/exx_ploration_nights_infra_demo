module "web" {
  source = "./../web"
  count = var.number_of_vms
  
  default_tags = var.default_tags
  public_subnet_id = var.public_subnet_id
  vpc_id = var.vpc_id
  ssh_key_name = aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.web_allow_http.id, aws_security_group.web_allow_ssh.id]
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

resource "aws_security_group" "web_allow_http" {
  name        = "web_allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
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
    { Name = "web_allow_http" })
} 