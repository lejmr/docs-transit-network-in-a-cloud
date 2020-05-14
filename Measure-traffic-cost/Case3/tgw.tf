resource "aws_ec2_transit_gateway" "tgw" {
  description                     = "Transit Gateway for ${var.region}"
}


resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1" {
  subnet_ids         = module.vpc1.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.vpc1.vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2" {
  subnet_ids         = module.vpc2.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.vpc2.vpc_id
}

# Routes
resource "aws_route" "default_to_tgw_vpc1" {
    count = "${length(module.vpc1.public_route_table_ids)}"
    route_table_id            = element(module.vpc1.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.0.0.0/8"
    transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "default_to_tgw_vpc2" {
    count = "${length(module.vpc2.public_route_table_ids)}"
    route_table_id            = element(module.vpc2.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.0.0.0/8"
    transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}