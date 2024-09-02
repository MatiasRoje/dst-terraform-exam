module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source = "./security_groups"

  vpc_id = module.vpc.vpc_id
}

module "bastion" {
  source = "./bastion"

  vpc_id             = module.vpc.vpc_id
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_b_id = module.vpc.public_subnet_b_id
  bastion_sg_id      = module.security_groups.bastion_sg_id
}

module "nat_gateway" {
  source = "./nat_gateway"

  vpc_id              = module.vpc.vpc_id
  public_subnet_a_id  = module.vpc.public_subnet_a_id
  public_subnet_b_id  = module.vpc.public_subnet_b_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
}

module "load_balancer" {
  source = "./load_balancer"

  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_b_id = module.vpc.public_subnet_b_id
  lb_sg_id           = module.security_groups.lb_sg_id
  vpc_id             = module.vpc.vpc_id
  web_asg_id         = module.web_server.web_asg_id
}

module "rds" {
  source = "./rds"

  db_password         = var.db_password
  vpc_id              = module.vpc.vpc_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
  db_sg_id            = module.security_groups.db_sg_id
}

module "web_server" {
  source = "./web_server"

  db_password         = var.db_password
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
  web_sg_id           = module.security_groups.web_sg_id
  db_endpoint         = module.rds.db_instance_endpoint
}