provider "aws" {
  region = "${var.region}"
}

module "office1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"
  # insert the 8 required variables here

  
  name = "VPC1"
  cidr = "10.250.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.250.1.0/24", "10.250.2.0/24", "10.250.3.0/24"]
  public_subnets  = ["10.250.101.0/24", "10.250.102.0/24", "10.250.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  one_nat_gateway_per_az = false
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}