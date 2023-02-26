module "jenkins" {
  source = "./modules/jenkins"
  default_tags = local.default_tags
}

#module "vm_setup" {
#  source = "./modules/jenkins"
#  depends_on = [module.jenkins]
#  default_tags = local.default_tags
#}