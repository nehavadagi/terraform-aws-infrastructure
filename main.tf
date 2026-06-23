terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source               = "./modules/vpc"
  project_name         = "nv-infra"
  availability_zone    = "ap-south-1a"
}

module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_pair_name     = var.key_pair_name
  my_ip_cidr        = var.my_ip_cidr
}