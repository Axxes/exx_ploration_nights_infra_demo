output "jenkins_public_ip" {
  value = module.jenkins.jenkins_public_ip
}

output "web_public_ips" {
  value = module.loadbalanced_vms.web_public_ips
}