provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "../../modules/vpc"
  env                = "prod"
  vpc_cidr           = "10.2.0.0/16"
  public_subnet_cidr = "10.2.1.0/24"
  az                 = "us-east-1c"
}

module "ec2" {
  source         = "../../modules/ec2"
  env            = "prod"
  ami            = "ami-04b4f1a9cf54c11d0"
  instance_type  = "t3.small" 
  subnet_id      = module.vpc.public.id
  key_name       = "ansible"
}

module "rds" {
  source   = "../../modules/rds"
  env      = "prod"
  db_user  = "admin"
  db_pass  = "Password123!"
  db_name  = "mydb"
  sg_id    = module.vpc.public.id
}
