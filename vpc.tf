# aws vpc #

resource "aws_vpc" "prod_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "prod_vpc"
  }
}

# aws subnets #

resource "aws_subnet" "prod_pubsub_1" {
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  cidr_block = var.prod_pubsub_1_cidr

  tags = {
    Name = "prod_pubsub_1"
  }
}

resource "aws_subnet" "prod_pubsub_2" {
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  cidr_block = var.prod_pubsub_2_cidr

  tags = {
    Name = "prod_pubsub_2"
  }
}

resource "aws_subnet" "prod_ptesub_1" {
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  cidr_block = var.prod_ptesub_1_cidr

  tags = {
    Name = "prod_ptesub_1"
  }
}

resource "aws_subnet" "prod_ptesub_2" {
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  cidr_block = var.prod_ptesub_2_cidr

  tags = {
    Name = "prod_ptesub_2"
  }
}

# aws route tables #

resource "aws_route_table" "prod_pub_rt" {
  vpc_id    = "${aws_vpc.prod_vpc.id}"

    tags    = {
      Name  = var.route_table_id
  }
}

resource "aws_route_table" "prod_pte_rt" {
  vpc_id    = "${aws_vpc.prod_vpc.id}"

    tags    = {
      Name  = var.route_table_id
  }
}

# Route table association to subnets #

resource "aws_route_table_association" "prod_pub_route_1_association" {
  subnet_id       = aws_subnet.prod_pubsub_1.id
  route_table_id  = aws_route_table.prod_pub_rt.id
}

resource "aws_route_table_association" "prod_pub_route_2_association" {
  subnet_id       = aws_subnet.prod_pubsub_2.id
  route_table_id  = aws_route_table.prod_pub_rt.id
}

resource "aws_route_table_association" "prod_pte_route_1_association" {
  subnet_id       = aws_subnet.prod_ptesub_1.id
  route_table_id  = aws_route_table.prod_pte_rt.id
}

resource "aws_route_table_association" "prod_pte_route_2_association" {
  subnet_id       = aws_subnet.prod_ptesub_2.id
  route_table_id  = aws_route_table.prod_pte_rt.id
}

# Internet gateway attached to vpc #

resource "aws_internet_gateway" "prod_IGW" {
  vpc_id  = aws_vpc.prod_vpc.id

    tags  = {
    Name  = var.internet_gateway
  }
}

# Routing IGW to public route table #

resource "aws_route" "pub_IGW_route" {
route_table_id          = aws_route_table.prod_pub_rt.id
gateway_id              = aws_internet_gateway.prod_IGW.id
destination_cidr_block  = var.pub_IGW_route_cidr
}

# Ellastic ip #

resource "aws_eip" "eip" {
  vpc = true
}

# Provisioning vpc Nat gateway #

resource "aws_nat_gateway" "prod_nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.prod_pubsub_1.id

    tags    = {
    Names   = var.nat_gateway
  }
}

# Routing Nat GW to the private route table #

resource "aws_route" "pte_nat_gateway_route" {
route_table_id          = aws_route_table.prod_pte_rt.id
gateway_id              = aws_nat_gateway.prod_nat_gateway.id

destination_cidr_block  = var.pte_nat_gateway_route_cidr
}