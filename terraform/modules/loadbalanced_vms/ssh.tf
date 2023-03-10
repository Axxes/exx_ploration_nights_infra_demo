resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  filename = "web_id_rsa_ssh"
  content  = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}

