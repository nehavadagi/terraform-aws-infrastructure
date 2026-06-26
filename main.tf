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

# ===== VPC Module =====
module "vpc" {
  source            = "./modules/vpc"
  project_name      = var.project_name
  availability_zone = var.availability_zone
}

# ===== ADD SECOND PRIVATE SUBNET =====
resource "aws_subnet" "private_2" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.3.0/24"              # Different CIDR than first private subnet
  availability_zone = "ap-south-1b"               # Different AZ than first private subnet

  tags = {
    Name = "${var.project_name}-private-subnet-2"
  }
}

# ===== EC2 Module =====
module "ec2" {
  source           = "./modules/ec2"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_pair_name    = var.key_pair_name
  my_ip_cidr       = var.my_ip_cidr
}

# ===== RDS Module =====
module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = [module.vpc.private_subnet_id, aws_subnet.private_2.id]   # ← Now passes 2 subnets
  ec2_security_group_id = module.ec2.security_group_id
  db_instance_class     = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}