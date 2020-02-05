provider "aws" {
  region = "${var.region}"
}

module "vpc1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"
  # insert the 8 required variables here

  
  name = "VPC1"
  cidr = "10.10.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  one_nat_gateway_per_az = false
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "vpc2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"
  # insert the 8 required variables here

  
  name = "VPC2"
  cidr = "10.11.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
  public_subnets  = ["10.11.101.0/24", "10.11.102.0/24", "10.11.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  one_nat_gateway_per_az = false
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "vpc3" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"
  # insert the 8 required variables here

  
  name = "VPC3"
  cidr = "10.12.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.12.1.0/24", "10.12.2.0/24", "10.12.3.0/24"]
  public_subnets  = ["10.12.101.0/24", "10.12.102.0/24", "10.12.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  one_nat_gateway_per_az = false
  single_nat_gateway = true
  
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}