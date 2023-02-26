module "jenkins" {
  source = "./modules/jenkins"
  default_tags = local.default_tags
}

module "web" {
  source = "./modules/web"
  depends_on = [module.jenkins]
  default_tags = local.default_tags
  public_subnet_id = module.jenkins.network_public_subnet_id
  vpc_id = module.jenkins.network_vpc_id
}