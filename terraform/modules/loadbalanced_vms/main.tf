module "web" {
  source = "./../web"
  count = var.number_of_vms
  
  default_tags = var.default_tags
  public_subnet_id = var.public_subnet_ids[0]
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

resource "aws_lb_target_group" "web_lb_tg" {
  name     = "web-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = 80
  }

  tags = var.default_tags
}

resource "aws_lb_target_group_attachment" "web_lb_tg_attachment" {
  for_each = toset(module.web[*].web_instance_id)
  target_group_arn = aws_lb_target_group.web_lb_tg.arn
  target_id        = each.key
  port             = 80
}

resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_lb_security_group.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = true

  tags = var.default_tags
}

resource "aws_security_group" "web_lb_security_group" {
  name        = "web_lb_security_group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags,
    { Name = "web_lb_allow_http" })
}

resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
    type             = "forward"
  }

  tags = merge(var.default_tags,
    { Name = "web_lb_listener" })
}