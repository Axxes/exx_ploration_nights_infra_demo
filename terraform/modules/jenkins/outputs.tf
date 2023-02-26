output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "network_public_subnet_id" {
  value = aws_subnet.main.id
}

output "network_vpc_id" {
  value = aws_vpc.main.id
}