data "aws_ami" "ubuntu1804" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-18.04*"]
  }

  owners      = ["099720109477"]
}

data "local_file" "ssh_key" {
  filename = "../files/id_rsa.pub"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "sshkey"
  public_key = "${data.local_file.ssh_key.content}"
}


// Komplet otevrena SG
resource "aws_security_group" "vpc1_allow_all" {
  name        = "vpc1_allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${module.vpc1.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "vpc2_allow_all" {
  name        = "vpc2_allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${module.vpc2.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "vpc3_allow_all" {
  name        = "vpc3_allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${module.vpc3.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

// EC2jky

module "vpc1_ec2_public" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "public1"
  instance_count         = 1

  ami                    = data.aws_ami.ubuntu1804.id
  instance_type          = "t2.micro"
  key_name               = "sshkey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc1_allow_all.id]
  subnet_id              = module.vpc1.public_subnets[0]
}

module "vpc2_ec2_public" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "public1"
  instance_count         = 1

  ami                    = data.aws_ami.ubuntu1804.id
  instance_type          = "t2.micro"
  key_name               = "sshkey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc2_allow_all.id]
  subnet_id              = module.vpc2.public_subnets[0]
}

module "vpc3_ec2_public" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "public1"
  instance_count         = 1

  ami                    = data.aws_ami.ubuntu1804.id
  instance_type          = "t2.micro"
  key_name               = "sshkey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc3_allow_all.id]
  subnet_id              = module.vpc3.public_subnets[0]
}
