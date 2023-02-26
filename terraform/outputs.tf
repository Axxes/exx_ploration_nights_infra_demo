output "jenkins_public_ip" {
  value = module.jenkins.jenkins_public_ip
}

output "web_public_ip" {
  value = module.web.web_public_ip
}