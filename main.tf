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

module "Kubernetes" {
  source                      = "./modules/eks"
  for_each                    = module.Network.collection_of_all_subnets_names_and_ids
  eks_cluster_name            = var.eks_cluster_name
  eks_cluster_iam_role_name   = var.eks_cluster_iam_role_name
  eks_nodegroup_iam_role_name = var.eks_nodegroup_iam_role_name
  eks_node_group_name         = var.eks_node_group_name
  eks_scaling_config          = var.eks_scaling_config
  eks_cluster_policy_arns     = var.eks_cluster_policy_arns
  eks_nodegroup_policy_arns   = var.eks_nodegroup_policy_arns
  eks_cluster_subnet_ids      = each.value
  eks_nodegroup_subnet_ids    = module.Network.private_subnets_ids
  eks_instance_types          = var.eks_instance_types
  eks_ami_type                = var.eks_ami_type
  eks_disk_size               = var.eks_disk_size
  #eks_capacity_type           = var.eks_capacity_type

}
