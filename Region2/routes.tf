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

resource "aws_route" "default_to_tgw_vpc3" {
    count = "${length(module.vpc3.public_route_table_ids)}"
    route_table_id            = element(module.vpc3.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.0.0.0/8"
    transit_gateway_id        = aws_ec2_transit_gateway.tgw.id
}