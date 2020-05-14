provider "aws" {
  region = "eu-west-1"
  alias = "left"
}

provider "aws" {
  region = "eu-central-1"
  alias = "right"
}

# TGW
resource "aws_ec2_transit_gateway" "tgw_left" {
  provider = aws.left
  description                     = "Transit Gateway for left"
}

resource "aws_ec2_transit_gateway" "tgw_right" {
  provider = aws.right
  description                     = "Transit Gateway for right"
}

# Peering is manually created

