output "internet_gateway_id" {
  value = module.Network.internet_gateway_id
}
output "vpc_id" {
  value = module.Network.vpc_id
}
output "subnet_id" {
  value = module.Network.subnet_id
}
output "subnets_name" {
  value = module.Network.subnets_name
}
output "public_subnets_ids" {
  value = module.Network.public_subnets_ids
}
output "private_subnets_ids" {
  value = module.Network.private_subnets_ids
}

output "private_route_table_ids" {
  value = module.Network.private_route_table_ids
}
output "public_route_table_ids" {
  value = module.Network.public_route_table_ids
}
output "nat_gateway_ids" {
  value = module.Network.nat_gateway_ids
}
