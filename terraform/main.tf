module "jenkins" {
  source       = "./modules/jenkins"
  default_tags = local.default_tags
}

module "loadbalanced_vms" {
  source     = "./modules/loadbalanced_vms"
  depends_on = [
    module.jenkins
  ]

  number_of_vms    = 2
  default_tags     = local.default_tags
  public_subnet_id = module.jenkins.network_public_subnet_id
  vpc_id           = module.jenkins.network_vpc_id
}

# module "web" {
#   source = "./modules/web"
#   depends_on = [module.jenkins]
#   count = 2

#   default_tags = local.default_tags
#   public_subnet_id = module.jenkins.network_public_subnet_id
#   vpc_id = module.jenkins.network_vpc_id
# }

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tfpl",
    {
      ansible_web_ips = module.loadbalanced_vms.web_public_ips,
      ansible_jenkins_ip  = module.jenkins.jenkins_public_ip
    }
  )
  filename        = "inventory.ini"
  file_permission = "0644"
}