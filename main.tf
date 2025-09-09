provider "aws" {
  region = var.region
}

module "vpc" {
  source             = "./modules/vpc"
  env                = var.env
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az                 = var.az
}

module "ec2" {
  source        = "./modules/ec2"
  env           = var.env
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  key_name      = var.key_name
}

module "rds" {
  source   = "./modules/rds"
  env      = var.env
  db_user  = var.db_user
  db_pass  = var.db_pass
  db_name  = var.db_name
  sg_id    = module.vpc.sg_id
  subnet_id = module.vpc.public_subnet_id
}
