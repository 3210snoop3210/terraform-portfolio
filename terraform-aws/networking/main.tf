#/networking/main.tf
data "aws_availability_zones" "available" {

}

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}

resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "aws-vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "aws_pub_sub" {
  count                   = var.public_sn_cont
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "aws_pub_${count.index + 1}"
  }
}

resource "aws_route_table_association" "aws_pub_assoc" {
  count          = var.public_sn_cont
  subnet_id      = aws_subnet.aws_pub_sub.*.id[count.index]
  route_table_id = aws_route_table.aws_rt.id
}

resource "aws_subnet" "aws_priv_sub" {
  count             = var.private_sn_count
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "aws_priv_${count.index + 1}"
  }

}

resource "aws_internet_gateway" "aws_ig" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "aws_igw"
  }
}

resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "aws_public"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.aws_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws_ig.id
}

resource "aws_default_route_table" "aws_priv_rt" {
  default_route_table_id = aws_vpc.aws_vpc.default_route_table_id
  tags = {
    Name = "aws_private"
  }
}


resource "aws_security_group" "aws_sg" {
  #count = length(local.security_groups)
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.aws_vpc.id
  dynamic "ingress" {

    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "aws_rds_subnetgroup" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "aws_rds_subnetgroup"
  subnet_ids = aws_subnet.aws_priv_sub.*.id
  tags = {
    Name = "aws_rds_sng"
  }
}