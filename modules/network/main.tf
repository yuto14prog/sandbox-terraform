# ===== VPC Resources =====

resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = var.vpc_name
  }
}

# ===== Gateway Resources =====

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-eigw"
  }
}

# ===== Subnet Resources =====

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.availability_zone
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, each.value.ipv6_index)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.vpc_name}-sub-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.availability_zone
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, each.value.ipv6_index)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.vpc_name}-sub-${each.key}"
  }
}

# ===== Route Table Resources =====

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-rtb-public"
  }
}

resource "aws_route" "public_ipv4" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "public_ipv6" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-rtb-private"
  }
}

resource "aws_route" "private_ipv6" {
  route_table_id              = aws_route_table.private.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.eigw.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
