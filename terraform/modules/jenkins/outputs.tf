output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "network_public_subnet_ids" {
  value = [aws_subnet.main.id,aws_subnet.main_2.id]
}

output "network_vpc_id" {
  value = aws_vpc.main.id
}