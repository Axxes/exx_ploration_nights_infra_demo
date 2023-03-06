resource "aws_instance" "web" {
  ami           = "ami-06e0ce9d3339cb039"
  instance_type = "t2.micro"
  # key_name           = aws_key_pair.ssh.key_name
  key_name = var.ssh_key_name
  associate_public_ip_address = true
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id          = var.public_subnet_id
  tags               = merge(var.default_tags,
    { Name = "web_instance" })
}

/*resource "aws_eip" "web_public_ip" {
  instance = aws_instance.web.id
  vpc      = true
}*/
