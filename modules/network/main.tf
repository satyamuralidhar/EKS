resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  for_each   = toset(var.subnets_name)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, var.cidr_newbits, 4)

  tags = {
    Name = format("%s", each.value)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_eip" "eip" {
  count = length(var.nat_gateway_name)
  tags = {
    Name = format("%s-%s", count.index, "eip")
  }
}

resource "aws_nat_gateway" "nat" {

  for_each      = toset(var.nat_gateway_name)
  allocation_id = index(local.nat_gateway_allocation_ids, each.key)
  subnet_id     = index(local.public_subnets_ids, each.key)

  tags = {
    Name = format("%s", each.key)
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "rtb" {
  for_each = toset(var.route_table_name)
  vpc_id   = aws_vpc.vpc.id
  dynamic "route" {
    for_each = var.route_table_name
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.public_subnet_type == true ? aws_internet_gateway.igw.id : local.nat_gateway_ids[each.key]

    }
  }

  tags = {
    Name = format("%s", each.key)
  }
}

resource "aws_route_table_association" "public_rtb_association" {
  for_each       = toset(local.public_subnets_ids)
  subnet_id      = each.key
  route_table_id = aws_route_table.rtb[local.public_route_table].id
}
resource "aws_route_table_association" "private_rtb_association" {
  for_each       = toset(local.private_subnets_ids)
  subnet_id      = each.key
  route_table_id = var.private_subnet_type == false ? index(local.private_route_table_ids, each.key) : null
}
