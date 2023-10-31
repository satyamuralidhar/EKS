output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_id" {

  value = [for i in aws_subnet.subnets : i.id]
}
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
output "subnets_name" {
  value = [for i in aws_subnet.subnets : i.tags.Name]
}
output "public_subnets_ids" {
  value = local.public_subnets_ids
}
output "private_subnets_ids" {
  value = local.private_subnets_ids
}

output "public_subnets_name" {
  value = local.public_subnets_name
}
output "private_subnets_name" {
  value = local.private_subnets_name
}

output "private_route_table_ids" {
  value = local.public_route_table_ids
}
output "public_route_table_ids" {
  value = local.private_route_table_ids
}
output "nat_gateway_ids" {
  value = local.nat_gateway_ids
}
output "collection_of_all_subnets_names_and_ids" {
  value = local.collection_of_all_subnets_names_and_ids
}
