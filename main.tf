module "Network" {
  source                = "./modules/network"
  vpc_name              = var.vpc_name
  vpc_cidr_block        = var.vpc_cidr_block
  subnets_name          = var.subnets_name
  public_subnet_type    = var.public_subnet_type
  private_subnet_type   = var.private_subnet_type
  cidr_newbits          = var.cidr_newbits
  internet_gateway_name = var.internet_gateway_name
  route_table_name      = var.route_table_name
  nat_gateway_name      = var.nat_gateway_name
  nat_subnets_prefix    = var.nat_subnets_prefix
}

