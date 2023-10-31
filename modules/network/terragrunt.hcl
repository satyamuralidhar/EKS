locals {
  nat_gateway_allocation_ids = [
    for i in aws_eip.eip : i.id
  ]
  public_route_table      = var.route_table_name[0]
  public_subnets_ids      = [for k in aws_subnet.subnets : k.id if(substr(k.tags.Name, 0, length(var.nat_subnets_prefix)) == var.nat_subnets_prefix)]
  private_subnets_ids     = [for k in aws_subnet.subnets : k.id if(substr(k.tags.Name, 0, length(var.nat_subnets_prefix)) != var.nat_subnets_prefix)]
  public_subnets_name     = [for k in aws_subnet.subnets : k.tags.Name if(substr(k.tags.Name, 0, length(var.nat_subnets_prefix)) == var.nat_subnets_prefix)]
  private_subnets_name    = [for k in aws_subnet.subnets : k.tags.Name if(substr(k.tags.Name, 0, length(var.nat_subnets_prefix)) != var.nat_subnets_prefix)]
  nat_gateway_ids         = [for i in aws_nat_gateway.nat : i.id]
  public_route_table_ids  = [for i in aws_route_table.rtb : i.id if(substr(i.tags.Name, 0, length(var.nat_subnets_prefix)) == var.nat_subnets_prefix)]
  private_route_table_ids = [for i in aws_route_table.rtb : i.id if(substr(i.tags.Name, 0, length(var.nat_subnets_prefix)) != var.nat_subnets_prefix)]
}