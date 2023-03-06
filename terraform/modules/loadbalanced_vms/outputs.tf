output "web_public_ips" {
  value = module.web.*.web_public_ip
}

output "web_lb_dns" {
  value = aws_lb.web_lb.dns_name
}