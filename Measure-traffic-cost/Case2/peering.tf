# resource "aws_vpc_peering_connection" "peering" {
#   provider = aws.left
#   peer_vpc_id   = module.vpc2.vpc_id
#   vpc_id        = module.vpc1.vpc_id
#   auto_accept   = true  
# }

resource "aws_route" "default_to_tgw_vpc1" {
    count = "${length(module.vpc1.public_route_table_ids)}"
    route_table_id            = element(module.vpc1.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.1.0.0/16"
    # vpc_peering_connection_id         = aws_vpc_peering_connection.peering.id
    vpc_peering_connection_id = "pcx-0e0fe4623fb0d0c02"
    provider = aws.left
}

resource "aws_route" "default_to_tgw_vpc2" {
    count = "${length(module.vpc2.public_route_table_ids)}"
    route_table_id            = element(module.vpc2.public_route_table_ids.*, count.index)
    destination_cidr_block    = "10.0.0.0/16"
    # vpc_peering_connection_id         = aws_vpc_peering_connection.peering.id
    vpc_peering_connection_id = "pcx-0e0fe4623fb0d0c02"
    provider = aws.right
}