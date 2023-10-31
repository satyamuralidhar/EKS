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

output "collection_of_all_subnets_names_and_ids" {
  value = module.Network.collection_of_all_subnets_names_and_ids
}

output "public_subnets_ids" {
  value = module.Network.public_subnets_ids
}
output "private_subnets_ids" {
  value = module.Network.private_subnets_ids
}

output "public_subnets_name" {
  value = module.Network.public_subnets_name
}
output "private_subnets_name" {
  value = module.Network.private_subnets_name
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

output "eks_cluster_subnet_ids" {
  value = module.Network.collection_of_all_subnets_names_and_ids
}
output "eks_nodegroup_subnet_ids" {
  value = [for i in module.Network.private_subnets_ids : i]
}
