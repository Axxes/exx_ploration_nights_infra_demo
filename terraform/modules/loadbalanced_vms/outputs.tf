output "web_public_ips" {
  value = module.web.*.web_public_ip
}