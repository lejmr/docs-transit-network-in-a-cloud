data "aws_ami" "vyos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["VyOS*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # VyOS
}

// resource "aws_ami_copy" "vyos" {
//   name              = "vyos"
//   description       = "A copy of ami-xxxxxxxx"
//   source_ami_id     = data.aws_ami.vyos.id
//   source_ami_region = "us-east-1"
// }


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${module.office1.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"

    content = <<EOT
preserve_hostname: true
hostname: vpn-gateway-central
final_message: "The system is finally up"
EOT
  }

}

resource "aws_instance" "router" {
  ami                         = "${data.aws_ami.vyos.id}"
  instance_type               = "t3.medium"
  // subnet_id                   = "${element(module.office1.public_subnets, 0}"
  subnet_id                   = "${element(module.office1.public_subnets, 0)}" 
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  // private_ip                  = "${cidrhost(cidrsubnet(element(module.office1.public_subnets.public_subnets_cidr_blocks, 0), 8, 0), var.vyosip)}"
  private_ip = "10.250.101.5"
  associate_public_ip_address = "true"
  key_name                    = "${aws_key_pair.ssh_key.key_name}"
  user_data_base64            = "${data.template_cloudinit_config.config.rendered}"

  tags = {
    Name = "vpn-gateway-central"
  }
}

