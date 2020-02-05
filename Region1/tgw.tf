resource "aws_ec2_transit_gateway" "tgw" {
  
  description                     = "Transit Gateway for ${var.region}"
//   default_route_table_association = "${var.enable_default_route_table_association ? enable : disable}"
//   default_route_table_propagation = "${var.enable_default_route_table_propagation ? enable : disable}"
//   auto_accept_shared_attachments  = "${var.auto_accept_attachments ? enable : disable}"
//   dns_support                     = "${var.enable_dns_support}"
//   amazon_side_asn                 = "${var.amazon_side_asn}"

}


resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1" {
//   subnet_ids         = [ element(module.vpc1.public_subnets, 1)]
  subnet_ids         = module.vpc1.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.vpc1.vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2" {
  subnet_ids         = module.vpc2.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.vpc2.vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc3" {
  subnet_ids         = module.vpc3.public_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = module.vpc3.vpc_id
}