resource "aws_ec2_transit_gateway" "tgw_left" {
  provider = aws.left
  description                     = "Transit Gateway for left"
}

resource "aws_ec2_transit_gateway" "tgw_right" {
  provider = aws.right
  description                     = "Transit Gateway for right"
}


resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1" {
  provider = aws.left
  subnet_ids         = module.vpc1.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw_left.id
  vpc_id             = module.vpc1.vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2" {
  provider = aws.right
  subnet_ids         = module.vpc2.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw_right.id
  vpc_id             = module.vpc2.vpc_id
}

# Assicoation routing
# At the moment there is no support in terraform, so this must be done manually in AWS Console

# Routes
resource "aws_route" "default_to_tgw_vpc1" {
    count = "${length(module.vpc1.public_route_table_ids)}"
    route_table_id            = element(module.vpc1.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.1.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.tgw_left.id
    provider = aws.left
}

resource "aws_route" "default_to_tgw_vpc2" {
    count = "${length(module.vpc2.public_route_table_ids)}"
    route_table_id            = element(module.vpc2.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.0.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.tgw_right.id
    provider = aws.right
}