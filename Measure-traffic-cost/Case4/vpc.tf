provider "aws" {
  region = "us-east-1"
  alias = "left"
}

provider "aws" {
  region = "us-east-2"
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

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
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

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
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