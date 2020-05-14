data "aws_ami" "ubuntu1804_left" {
  provider = aws.left
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-18.04*"]
  }

  owners      = ["099720109477"]
}

data "aws_ami" "ubuntu1804_right" {
  provider = aws.right
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


resource "aws_key_pair" "ssh_key_left" {
  provider = aws.left
  key_name   = "sshkey"
  public_key = data.local_file.ssh_key.content
}

resource "aws_key_pair" "ssh_key_right" {
  provider = aws.right
  key_name   = "sshkey"
  public_key = data.local_file.ssh_key.content
}

// Komplet otevrena SG
resource "aws_security_group" "vpc1_allow_all" {
  provider = aws.left
  name        = "vpc1_allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc1.vpc_id

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
  provider = aws.right
  name        = "vpc2_allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc2.vpc_id

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
  providers = {
    aws = aws.left
  }

  name                   = "public1"
  instance_count         = 1

  ami                    = data.aws_ami.ubuntu1804_left.id
  instance_type          = "t3.micro"
  key_name               = "sshkey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc1_allow_all.id]
  subnet_id              = module.vpc1.public_subnets[0]
}


module "vpc2_ec2_public" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  providers = {
    aws = aws.right
  }

  name                   = "public1"
  instance_count         = 1

  ami                    = data.aws_ami.ubuntu1804_right.id
  instance_type          = "t3.micro"
  key_name               = "sshkey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc2_allow_all.id]
  subnet_id              = module.vpc2.public_subnets[0]
}
