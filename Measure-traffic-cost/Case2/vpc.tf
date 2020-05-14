provider "aws" {
  region = "eu-north-1"
  alias = "left"
}

provider "aws" {
  region = "eu-west-3"
  alias = "right"
}

module "vpc1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"
  providers = {
    aws = aws.left
  }
  # insert the 8 required variables here
  
  name = "VPC1"
  cidr = "10.0.0.0/16"

  azs             = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
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
  providers = {
    aws = aws.right
  }
  # insert the 8 required variables here

  name = "VPC2"
  cidr = "10.1.0.0/16"

  azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  one_nat_gateway_per_az = false
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}